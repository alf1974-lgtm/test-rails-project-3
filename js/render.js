/**
 * render.js
 * All canvas drawing: the board, the active piece, the ghost piece,
 * the next-piece preview, and the pause overlay.
 *
 * Nothing in this module mutates game state — it only reads it.
 */

import { ROWS, COLS, CELL, BONUS_COLORS, BONUS_TEXT_COLORS, BONUS, LETTER_VALUES } from './constants.js';
import { getBoard }   from './board.js';
import { getCurrent, getNext, ghostRow, blocks } from './piece.js';

// ── Canvas references ──────────────────────────────────────────────
const boardCanvas = document.getElementById('board-canvas');
const ctx         = boardCanvas.getContext('2d');
const nextCanvas  = document.getElementById('next-canvas');
const nctx        = nextCanvas.getContext('2d');

// ── roundRect polyfill ─────────────────────────────────────────────
// Needed for browsers that don't yet support the native API.
if (!CanvasRenderingContext2D.prototype.roundRect) {
  CanvasRenderingContext2D.prototype.roundRect = function (x, y, w, h, r) {
    const [tl, tr, br, bl] = Array.isArray(r) ? [...r, ...r].slice(0, 4) : [r, r, r, r];
    this.beginPath();
    this.moveTo(x + tl, y);
    this.lineTo(x + w - tr, y);
    this.quadraticCurveTo(x + w, y, x + w, y + tr);
    this.lineTo(x + w, y + h - br);
    this.quadraticCurveTo(x + w, y + h, x + w - br, y + h);
    this.lineTo(x + bl, y + h);
    this.quadraticCurveTo(x, y + h, x, y + h - bl);
    this.lineTo(x, y + tl);
    this.quadraticCurveTo(x, y, x + tl, y);
    this.closePath();
    return this;
  };
}

// ── Single-cell drawing ────────────────────────────────────────────

/**
 * Draw one tetromino block at pixel position (x, y).
 *
 * @param {CanvasRenderingContext2D} context
 * @param {number}  x
 * @param {number}  y
 * @param {number}  size    Cell size in pixels.
 * @param {string}  color   Piece colour (used when no bonus overrides it).
 * @param {string}  letter  Uppercase letter to render.
 * @param {string}  bonus   One of the BONUS constants.
 * @param {number}  [alpha] Global alpha (default 1).
 */
export function drawCell(context, x, y, size, color, letter, bonus, alpha = 1) {
  context.save();
  context.globalAlpha = alpha;

  const bonusColor = BONUS_COLORS[bonus];
  const fillColor  = bonusColor ?? color;

  // ── Main block fill ──────────────────────────────────────────────
  context.fillStyle = fillColor;
  context.beginPath();
  context.roundRect(x + 1, y + 1, size - 2, size - 2, 3);
  context.fill();

  // ── Top bevel (highlight) ────────────────────────────────────────
  context.fillStyle = 'rgba(255,255,255,0.25)';
  context.beginPath();
  context.roundRect(x + 1, y + 1, size - 2, 6, [3, 3, 0, 0]);
  context.fill();

  // ── Bottom bevel (shadow) ────────────────────────────────────────
  context.fillStyle = 'rgba(0,0,0,0.3)';
  context.beginPath();
  context.roundRect(x + 1, y + size - 7, size - 2, 6, [0, 0, 3, 3]);
  context.fill();

  // ── Bonus tag (top-left corner) ──────────────────────────────────
  if (bonus && bonus !== BONUS.NONE) {
    context.font      = `bold ${Math.floor(size * 0.22)}px sans-serif`;
    context.fillStyle = BONUS_TEXT_COLORS[bonus];
    context.globalAlpha = alpha * 0.85;
    context.fillText(bonus.toUpperCase(), x + 3, y + Math.floor(size * 0.28));
  }

  // ── Letter ───────────────────────────────────────────────────────
  if (letter) {
    const textColor = bonusColor ? BONUS_TEXT_COLORS[bonus] : '#ffffff';
    context.globalAlpha    = alpha;
    context.font           = `bold ${Math.floor(size * 0.52)}px 'Segoe UI', sans-serif`;
    context.fillStyle      = textColor;
    context.textAlign      = 'center';
    context.textBaseline   = 'middle';
    context.fillText(letter, x + size / 2, y + size / 2 + 1);

    // Scrabble point value (bottom-right subscript)
    const val = LETTER_VALUES[letter] ?? 1;
    context.font         = `${Math.floor(size * 0.22)}px sans-serif`;
    context.fillStyle    = textColor;
    context.globalAlpha  = alpha * 0.75;
    context.textAlign    = 'right';
    context.textBaseline = 'bottom';
    context.fillText(val, x + size - 3, y + size - 2);
  }

  context.restore();
}

// ── Board ──────────────────────────────────────────────────────────

/**
 * Redraw the entire board canvas: background, grid, settled cells,
 * ghost piece, active piece, and (if paused) the pause overlay.
 *
 * @param {boolean} paused
 * @param {boolean} gameOver
 */
export function drawBoard(paused, gameOver) {
  const board   = getBoard();
  const current = getCurrent();

  // Background
  ctx.fillStyle = '#0d1b2a';
  ctx.fillRect(0, 0, boardCanvas.width, boardCanvas.height);

  // Subtle grid lines
  ctx.strokeStyle = 'rgba(255,255,255,0.04)';
  ctx.lineWidth   = 1;
  for (let r = 0; r <= ROWS; r++) {
    ctx.beginPath();
    ctx.moveTo(0, r * CELL);
    ctx.lineTo(COLS * CELL, r * CELL);
    ctx.stroke();
  }
  for (let c = 0; c <= COLS; c++) {
    ctx.beginPath();
    ctx.moveTo(c * CELL, 0);
    ctx.lineTo(c * CELL, ROWS * CELL);
    ctx.stroke();
  }

  // Settled cells
  for (let r = 0; r < ROWS; r++) {
    for (let c = 0; c < COLS; c++) {
      const cell = board[r][c];
      if (cell) {
        drawCell(ctx, c * CELL, r * CELL, CELL, cell.color, cell.letter, cell.bonus);
      }
    }
  }

  // Ghost piece
  if (current && !gameOver) {
    const gr = ghostRow();
    for (const b of blocks(current)) {
      const ghostR = gr + (b.r - current.row);
      drawCell(ctx, b.c * CELL, ghostR * CELL, CELL, current.def.color, b.letter, b.bonus, 0.18);
    }
  }

  // Active piece
  if (current && !gameOver) {
    for (const b of blocks(current)) {
      if (b.r >= 0) {
        drawCell(ctx, b.c * CELL, b.r * CELL, CELL, b.color, b.letter, b.bonus);
      }
    }
  }

  // Pause overlay
  if (paused) {
    ctx.fillStyle    = 'rgba(10,10,20,0.7)';
    ctx.fillRect(0, 0, boardCanvas.width, boardCanvas.height);
    ctx.fillStyle    = '#e94560';
    ctx.font         = 'bold 36px Segoe UI';
    ctx.textAlign    = 'center';
    ctx.textBaseline = 'middle';
    ctx.fillText('PAUSED', boardCanvas.width / 2, boardCanvas.height / 2);
  }
}

// ── Next-piece preview ─────────────────────────────────────────────

/** Redraw the small next-piece canvas. */
export function drawNext() {
  const next = getNext();

  nctx.fillStyle = '#0d1b2a';
  nctx.fillRect(0, 0, nextCanvas.width, nextCanvas.height);

  if (!next) return;

  const cellSize = 24;
  const rot      = next.def.rotations[0];
  const minR     = Math.min(...rot.map(o => o[0]));
  const maxR     = Math.max(...rot.map(o => o[0]));
  const minC     = Math.min(...rot.map(o => o[1]));
  const maxC     = Math.max(...rot.map(o => o[1]));
  const pw       = (maxC - minC + 1) * cellSize;
  const ph       = (maxR - minR + 1) * cellSize;
  const ox       = (nextCanvas.width  - pw) / 2;
  const oy       = (nextCanvas.height - ph) / 2;

  rot.forEach(([dr, dc], i) => {
    const x = ox + (dc - minC) * cellSize;
    const y = oy + (dr - minR) * cellSize;
    drawCell(nctx, x, y, cellSize, next.def.color, next.cells[i].letter, next.cells[i].bonus);
  });
}
