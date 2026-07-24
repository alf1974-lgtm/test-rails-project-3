/**
 * board.js
 * Owns the settled-cell grid and all operations on it:
 *   - creating / resetting the board
 *   - collision detection (canPlace)
 *   - clearing full rows (Tetris mechanic)
 *   - applying gravity after word blocks are removed
 */

import { ROWS, COLS } from './constants.js';

// ── Board state ────────────────────────────────────────────────────
// A 2-D array [row][col] of cell objects or null.
// Cell: { color: string, letter: string, bonus: string }
let _board = [];

/** Return the live board array (read/write by other modules). */
export function getBoard() { return _board; }

/** Initialise (or reset) the board to all-empty. */
export function resetBoard() {
  _board = Array.from({ length: ROWS }, () => Array(COLS).fill(null));
}

// ── Collision detection ────────────────────────────────────────────

/**
 * Returns true if the given piece can occupy (row, col) at rotation rot
 * without going out of bounds or overlapping a settled cell.
 *
 * @param {object} piece
 * @param {number} row
 * @param {number} col
 * @param {number} rot
 * @returns {boolean}
 */
export function canPlace(piece, row, col, rot) {
  for (const [dr, dc] of piece.def.rotations[rot]) {
    const nr = row + dr;
    const nc = col + dc;
    if (nr < 0 || nr >= ROWS || nc < 0 || nc >= COLS) return false;
    if (_board[nr][nc]) return false;
  }
  return true;
}

// ── Row clearing ───────────────────────────────────────────────────

/**
 * Scans the board for completely filled rows, removes them, and shifts
 * everything above down.
 *
 * @returns {number}  The number of rows cleared (0–4).
 */
export function clearFullRows() {
  let cleared = 0;
  for (let r = ROWS - 1; r >= 0; r--) {
    if (_board[r].every(cell => cell !== null)) {
      _board.splice(r, 1);
      _board.unshift(Array(COLS).fill(null));
      cleared++;
      r++; // re-check the same index after the shift
    }
  }
  return cleared;
}

// ── Gravity ────────────────────────────────────────────────────────

/**
 * After word blocks are removed, compact each column so that cells fall
 * to the lowest available row (column-by-column gravity).
 */
export function applyGravity() {
  for (let c = 0; c < COLS; c++) {
    // Collect non-null cells top-to-bottom
    const cells = [];
    for (let r = 0; r < ROWS; r++) {
      if (_board[r][c] !== null) cells.push(_board[r][c]);
    }
    // Re-fill column: empty rows on top, cells packed to the bottom
    for (let r = ROWS - 1; r >= 0; r--) {
      _board[r][c] = cells.length > 0 ? cells.pop() : null;
    }
  }
}
