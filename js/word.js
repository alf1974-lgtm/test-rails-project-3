/**
 * word.js
 * Manages the word-typing state and the Boggle-style board search.
 *
 * Responsibilities:
 *  - Track the word currently being typed (_typedWord).
 *  - Validate submissions against the dictionary and the board.
 *  - Find a valid adjacency path on the board (DFS, 8-directional).
 *  - Remove matched cells and trigger gravity.
 *  - Maintain the word-play history.
 *  - Notify game.js of earned points via a callback.
 */

import { ROWS, COLS } from './constants.js';
import { DICTIONARY }  from './dictionary.js';
import { getBoard, applyGravity } from './board.js';
import { scoreWord }   from './scoring.js';
import { updateWordDisplay, showFeedback, renderHistory } from './hud.js';

// ── State ──────────────────────────────────────────────────────────
let _typedWord   = '';
let _wordHistory = [];   // [{ word: string, pts: number }]

export function getTypedWord()   { return _typedWord; }
export function getWordHistory() { return _wordHistory; }

// ── Callback injected by game.js ───────────────────────────────────
let _onWordScore = (_pts) => {};
export function setWordScoreCallback(fn) { _onWordScore = fn; }

// ── Typed-word mutations ───────────────────────────────────────────

export function appendLetter(letter) {
  if (_typedWord.length < 15) {
    _typedWord += letter.toUpperCase();
    updateWordDisplay(_typedWord);
  }
}

export function deleteLetter() {
  _typedWord = _typedWord.slice(0, -1);
  updateWordDisplay(_typedWord);
}

export function clearWord() {
  _typedWord = '';
  updateWordDisplay(_typedWord);
  showFeedback('Word cleared', 'feedback-info');
}

export function resetWordState() {
  _typedWord   = '';
  _wordHistory = [];
  updateWordDisplay(_typedWord);
}

// ── Submission ─────────────────────────────────────────────────────

/**
 * Validate and score the currently typed word.
 * On success: removes matched cells, applies gravity, updates history.
 * On failure: shows an appropriate error message.
 */
export function submitWord() {
  const word = _typedWord.toUpperCase();
  _typedWord = '';
  updateWordDisplay(_typedWord);

  if (word.length < 2) {
    showFeedback('Too short!', 'feedback-bad');
    return;
  }

  if (!DICTIONARY.has(word.toLowerCase())) {
    showFeedback(`"${word}" not in dictionary`, 'feedback-bad');
    return;
  }

  const path = findWordOnBoard(word);
  if (!path) {
    showFeedback(`Letters for "${word}" not on board`, 'feedback-bad');
    return;
  }

  const board = getBoard();
  const matchedCells = path.map(([r, c]) => board[r][c]);
  const pts = scoreWord(word, matchedCells);

  // Remove matched cells from the board
  for (const [r, c] of path) {
    board[r][c] = null;
  }
  applyGravity();

  // Record and display
  _wordHistory.unshift({ word, pts });
  if (_wordHistory.length > 20) _wordHistory.pop();
  renderHistory(_wordHistory);

  const bonusNote = word.length >= 7 ? ' (7+ bonus!)' : '';
  showFeedback(`"${word}" +${pts} pts${bonusNote}`, 'feedback-ok');

  _onWordScore(pts);
}

// ── Board search ───────────────────────────────────────────────────

/**
 * Boggle-style DFS: find a path of adjacent (8-directional) settled cells
 * whose letters spell `word` in order.
 *
 * @param {string} word  Uppercase word to search for.
 * @returns {Array<[number,number]>|null}  Array of [row, col] pairs, or null.
 */
export function findWordOnBoard(word) {
  const board   = getBoard();
  const visited = Array.from({ length: ROWS }, () => Array(COLS).fill(false));

  const DIRS = [
    [-1, -1], [-1, 0], [-1, 1],
    [ 0, -1],           [ 0, 1],
    [ 1, -1], [ 1, 0], [ 1, 1],
  ];

  function dfs(idx, r, c, path) {
    if (idx === word.length) return path;
    if (r < 0 || r >= ROWS || c < 0 || c >= COLS) return null;
    if (visited[r][c]) return null;
    if (!board[r][c]) return null;
    if (board[r][c].letter !== word[idx]) return null;

    visited[r][c] = true;
    path.push([r, c]);

    for (const [dr, dc] of DIRS) {
      const result = dfs(idx + 1, r + dr, c + dc, path);
      if (result) return result;
    }

    path.pop();
    visited[r][c] = false;
    return null;
  }

  for (let r = 0; r < ROWS; r++) {
    for (let c = 0; c < COLS; c++) {
      if (board[r][c] && board[r][c].letter === word[0]) {
        const result = dfs(0, r, c, []);
        if (result) return result;
      }
    }
  }

  return null;
}
