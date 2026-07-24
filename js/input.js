/**
 * input.js
 * Keyboard event handling.
 *
 * Wires up all keydown events and delegates to the appropriate module.
 * Imports game.js for pause/game-over state, piece.js for movement,
 * and word.js for word-typing actions.
 */

import { isOverlayVisible } from './hud.js';
import { getGameState, startGame, togglePause } from './game.js';
import {
  moveLeft, moveRight, rotate, softDrop, hardDrop,
} from './piece.js';
import {
  getTypedWord, appendLetter, deleteLetter, clearWord, submitWord,
} from './word.js';

/**
 * Attach the global keydown listener.
 * Call once during initialisation.
 */
export function initInput() {
  document.addEventListener('keydown', handleKey);
  document.getElementById('start-btn').addEventListener('click', startGame);
}

function handleKey(e) {
  // ── Overlay (start / game-over screen) ──────────────────────────
  if (isOverlayVisible()) {
    if (e.key === 'Enter' || e.key === ' ') {
      e.preventDefault();
      startGame();
    }
    return;
  }

  const { gameOver, paused } = getGameState();
  if (gameOver) return;

  // ── Pause toggle (always available while playing) ────────────────
  if (e.key === 'p' || e.key === 'P') {
    togglePause();
    return;
  }

  if (paused) return;

  // ── Tetris movement ──────────────────────────────────────────────
  switch (e.key) {
    case 'ArrowLeft':
      e.preventDefault();
      moveLeft();
      return;

    case 'ArrowRight':
      e.preventDefault();
      moveRight();
      return;

    case 'ArrowUp':
      e.preventDefault();
      rotate();
      return;

    case 'ArrowDown':
      e.preventDefault();
      softDrop();
      return;

    case ' ':
      e.preventDefault();
      // Hard-drop only when the player isn't mid-word
      if (getTypedWord().length === 0) hardDrop();
      return;
  }

  // ── Word typing ──────────────────────────────────────────────────
  switch (e.key) {
    case 'Enter':
      e.preventDefault();
      if (getTypedWord().length > 0) submitWord();
      return;

    case 'Backspace':
      e.preventDefault();
      deleteLetter();
      return;

    case 'Escape':
      clearWord();
      return;
  }

  // Letter keys (A–Z, no modifier)
  if (
    e.key.length === 1 &&
    /^[a-zA-Z]$/.test(e.key) &&
    !e.ctrlKey &&
    !e.metaKey
  ) {
    appendLetter(e.key);
  }
}
