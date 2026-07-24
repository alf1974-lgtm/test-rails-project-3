/**
 * piece.js
 * Manages the active and next tetromino pieces:
 *   - spawning pieces with random letters / bonus tiles
 *   - computing block positions (blocks())
 *   - movement: left, right, soft-drop, hard-drop, rotate (with wall-kick)
 *   - locking a piece onto the board
 */

import { PIECES, COLS, ROWS } from './constants.js';
import { randomLetter, randomBonus } from './letters.js';
import { canPlace, getBoard, clearFullRows } from './board.js';

// ── Active-piece state ─────────────────────────────────────────────
let _current = null;
let _next    = null;

export function getCurrent() { return _current; }
export function getNext()    { return _next;    }

// ── Callbacks injected by game.js ──────────────────────────────────
// Avoids circular imports: piece.js doesn't import game.js directly.
let _onLock      = () => {};  // called after a piece is locked
let _onScoreAdd  = () => {};  // called with (points) to add to score
let _onGameOver  = () => {};  // called when a new piece can't be placed

export function setPieceCallbacks({ onLock, onScoreAdd, onGameOver }) {
  _onLock     = onLock     || _onLock;
  _onScoreAdd = onScoreAdd || _onScoreAdd;
  _onGameOver = onGameOver || _onGameOver;
}

// ── Spawning ───────────────────────────────────────────────────────

/**
 * Create a brand-new piece with random type, letters, and bonus tiles.
 * @returns {object}
 */
export function createPiece() {
  const idx = Math.floor(Math.random() * PIECES.length);
  const def = PIECES[idx];
  // One letter + bonus per block, indexed to match rotations[0]
  const cells = def.rotations[0].map(() => ({
    letter: randomLetter(),
    bonus:  randomBonus(),
  }));
  return {
    def,
    rot: 0,
    row: 0,
    col: Math.floor(COLS / 2) - 1,
    cells,
  };
}

/**
 * Promote _next → _current, generate a new _next.
 * Triggers game-over if the incoming piece has no valid spawn position.
 */
export function spawnNext() {
  _current = _next;
  _next    = createPiece();
  if (!canPlace(_current, _current.row, _current.col, _current.rot)) {
    _onGameOver();
  }
}

/** Seed both _current and _next at game start. */
export function initPieces() {
  _next = createPiece();
  spawnNext();
}

// ── Block positions ────────────────────────────────────────────────

/**
 * Expand a piece into its individual block descriptors.
 *
 * @param {object} piece
 * @param {number} [overrideRot]  Use this rotation instead of piece.rot.
 * @returns {Array<{r, c, letter, bonus, color}>}
 */
export function blocks(piece, overrideRot) {
  const rot = overrideRot !== undefined ? overrideRot : piece.rot;
  return piece.def.rotations[rot].map(([dr, dc], i) => ({
    r:      piece.row + dr,
    c:      piece.col + dc,
    letter: piece.cells[i].letter,
    bonus:  piece.cells[i].bonus,
    color:  piece.def.color,
  }));
}

// ── Movement ───────────────────────────────────────────────────────

export function moveLeft() {
  if (canPlace(_current, _current.row, _current.col - 1, _current.rot)) {
    _current.col--;
  }
}

export function moveRight() {
  if (canPlace(_current, _current.row, _current.col + 1, _current.rot)) {
    _current.col++;
  }
}

export function softDrop() {
  if (canPlace(_current, _current.row + 1, _current.col, _current.rot)) {
    _current.row++;
    _onScoreAdd(1);
  } else {
    lockPiece();
  }
}

export function hardDrop() {
  let dropped = 0;
  while (canPlace(_current, _current.row + 1, _current.col, _current.rot)) {
    _current.row++;
    dropped++;
  }
  _onScoreAdd(dropped * 2);
  lockPiece();
}

/**
 * Rotate the active piece clockwise with simple wall-kick offsets
 * (0, −1, +1, −2, +2).
 */
export function rotate() {
  const newRot = (_current.rot + 1) % 4;
  for (const kick of [0, -1, 1, -2, 2]) {
    if (canPlace(_current, _current.row, _current.col + kick, newRot)) {
      _current.col += kick;
      _current.rot  = newRot;
      return;
    }
  }
}

// ── Locking ────────────────────────────────────────────────────────

/**
 * Stamp the active piece onto the board, clear any full rows, then
 * notify game.js via the onLock callback (which handles scoring and
 * spawning the next piece).
 */
export function lockPiece() {
  const board = getBoard();
  for (const b of blocks(_current)) {
    if (b.r >= 0 && b.r < ROWS && b.c >= 0 && b.c < COLS) {
      board[b.r][b.c] = { color: b.color, letter: b.letter, bonus: b.bonus };
    }
  }
  const linesCleared = clearFullRows();
  _onLock(linesCleared);
}

// ── Ghost row ──────────────────────────────────────────────────────

/**
 * Returns the row index where the active piece would land if dropped now.
 * @returns {number}
 */
export function ghostRow() {
  let gr = _current.row;
  while (canPlace(_current, gr + 1, _current.col, _current.rot)) gr++;
  return gr;
}
