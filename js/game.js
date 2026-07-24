/**
 * game.js
 * Top-level game orchestrator.
 *
 * Owns:
 *  - score / level / lines / paused / gameOver state
 *  - the requestAnimationFrame loop
 *  - drop-interval timing
 *
 * Wires together all other modules via callbacks so that lower-level
 * modules (piece, word) don't need to import game.js directly.
 */

import { resetBoard, canPlace } from './board.js';
import {
  initPieces, spawnNext, setPieceCallbacks,
  getCurrent, lockPiece,
} from './piece.js';
import { setWordScoreCallback, resetWordState } from './word.js';
import { scoreClear }  from './scoring.js';
import { drawBoard, drawNext } from './render.js';
import {
  updateHUD, showFeedback, renderHistory,
  showGameOverScreen, hideOverlay,
} from './hud.js';
import { initInput }   from './input.js';

// ── Game state ─────────────────────────────────────────────────────
let _score        = 0;
let _level        = 1;
let _lines        = 0;
let _paused       = false;
let _gameOver     = false;
let _dropInterval = 800;   // ms between automatic downward steps
let _lastDrop     = 0;     // timestamp of the last auto-drop
let _animId       = null;

/** Read-only snapshot used by input.js. */
export function getGameState() {
  return {
    score:    _score,
    level:    _level,
    lines:    _lines,
    paused:   _paused,
    gameOver: _gameOver,
  };
}

// ── Bootstrap ──────────────────────────────────────────────────────

/** Called once on page load. */
export function boot() {
  initInput();
  // The start screen is already visible in the HTML; nothing else needed.
}

// ── Start / restart ────────────────────────────────────────────────

export function startGame() {
  // Reset all state
  _score        = 0;
  _level        = 1;
  _lines        = 0;
  _paused       = false;
  _gameOver     = false;
  _dropInterval = 800;
  _lastDrop     = performance.now();

  resetBoard();
  resetWordState();
  renderHistory([]);
  updateHUD(_score, _level, _lines);
  hideOverlay();

  // Wire up callbacks so piece.js and word.js can report back
  setPieceCallbacks({
    onLock:     handleLock,
    onScoreAdd: addScore,
    onGameOver: triggerGameOver,
  });
  setWordScoreCallback(addScore);

  // Spawn the first two pieces
  initPieces();

  // Start the loop
  if (_animId) cancelAnimationFrame(_animId);
  _animId = requestAnimationFrame(gameLoop);
}

// ── Pause ──────────────────────────────────────────────────────────

export function togglePause() {
  _paused = !_paused;
}

// ── Score helpers ──────────────────────────────────────────────────

function addScore(pts) {
  _score += pts;
  updateHUD(_score, _level, _lines);
}

// ── Lock callback (called by piece.js after stamping onto board) ───

/**
 * @param {number} linesCleared  Rows cleared by this lock (0–4).
 */
function handleLock(linesCleared) {
  if (linesCleared > 0) {
    const pts = scoreClear(linesCleared, _level);
    _score += pts;
    _lines += linesCleared;
    _level  = Math.floor(_lines / 10) + 1;
    _dropInterval = Math.max(100, 800 - (_level - 1) * 70);
    updateHUD(_score, _level, _lines);
    showFeedback(
      `+${pts} pts — ${linesCleared} line${linesCleared > 1 ? 's' : ''}!`,
      'feedback-ok',
    );
  }
  // Spawn the next piece (may trigger game-over via the callback)
  spawnNext();
}

// ── Game over ──────────────────────────────────────────────────────

function triggerGameOver() {
  _gameOver = true;
  cancelAnimationFrame(_animId);
  drawBoard(_paused, _gameOver);
  showGameOverScreen(_score);
}

// ── Auto-drop tick ─────────────────────────────────────────────────

/**
 * Called once per drop interval.  Moves the active piece down one row,
 * or locks it if it can't move further.
 */
function tickDrop() {
  const current = getCurrent();
  if (!current) return;
  if (canPlace(current, current.row + 1, current.col, current.rot)) {
    current.row++;
  } else {
    lockPiece();
  }
}

// ── Main loop ──────────────────────────────────────────────────────

function gameLoop(ts) {
  if (_gameOver) return;

  if (!_paused) {
    if (ts - _lastDrop >= _dropInterval) {
      _lastDrop = ts;
      tickDrop();
    }
  } else {
    // Don't accumulate time while paused
    _lastDrop = ts;
  }

  drawBoard(_paused, _gameOver);
  drawNext();
  _animId = requestAnimationFrame(gameLoop);
}
