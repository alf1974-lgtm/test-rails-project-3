/**
 * Tic Tac Toe — two players, same browser
 *
 * Player 1 = X  |  Player 2 = O
 * Players alternate turns by passing the mouse to each other.
 */

'use strict';

// ── Winning combinations (indices into the 9-cell board) ──────────────────
const WIN_COMBOS = [
  [0, 1, 2], // top row
  [3, 4, 5], // middle row
  [6, 7, 8], // bottom row
  [0, 3, 6], // left col
  [1, 4, 7], // middle col
  [2, 5, 8], // right col
  [0, 4, 8], // diagonal ↘
  [2, 4, 6], // diagonal ↙
];

// ── DOM references ─────────────────────────────────────────────────────────
const cells         = Array.from(document.querySelectorAll('.cell'));
const playerIndicator = document.getElementById('player-indicator');
const overlay       = document.getElementById('overlay');
const overlayMsg    = document.getElementById('overlay-message');
const restartBtn    = document.getElementById('restart-btn');
const resetScoresBtn = document.getElementById('reset-scores-btn');
const scoreX        = document.getElementById('score-x');
const scoreO        = document.getElementById('score-o');
const scoreDraw     = document.getElementById('score-draw');

// ── Game state ─────────────────────────────────────────────────────────────
let board        = Array(9).fill(null); // null | 'X' | 'O'
let currentMark  = 'X';                // whose turn it is
let gameOver     = false;

const scores = { X: 0, O: 0, draw: 0 };

// ── Helpers ────────────────────────────────────────────────────────────────

/** Return the winning combo array if `mark` has won, otherwise null. */
function getWinCombo(mark) {
  return WIN_COMBOS.find(combo => combo.every(i => board[i] === mark)) ?? null;
}

/** True when all cells are filled. */
function isBoardFull() {
  return board.every(cell => cell !== null);
}

/** Update the status-bar text and colour class. */
function updateIndicator() {
  const player = currentMark === 'X' ? 'Player 1' : 'Player 2';
  playerIndicator.textContent = `${player}'s turn (${currentMark})`;
  playerIndicator.className   = currentMark === 'X' ? 'player-x' : 'player-o';
}

/** Show the end-of-game overlay with a message. */
function showOverlay(message) {
  overlayMsg.textContent = message;
  overlay.classList.remove('hidden');
}

/** Highlight the three winning cells. */
function highlightWinners(combo) {
  combo.forEach(i => cells[i].classList.add('winner'));
}

// ── Core game logic ────────────────────────────────────────────────────────

function handleCellClick(event) {
  const cell  = event.currentTarget;
  const index = parseInt(cell.dataset.index, 10);

  // Ignore clicks on already-filled cells or after game ends
  if (board[index] !== null || gameOver) return;

  // Place the mark
  board[index] = currentMark;
  cell.textContent = currentMark;
  cell.classList.add(currentMark.toLowerCase());
  cell.disabled = true;

  // Check for a win
  const winCombo = getWinCombo(currentMark);
  if (winCombo) {
    gameOver = true;
    highlightWinners(winCombo);
    const winner = currentMark === 'X' ? 'Player 1 (X)' : 'Player 2 (O)';
    scores[currentMark]++;
    updateScoreboard();
    // Small delay so the winning animation is visible before the overlay appears
    setTimeout(() => showOverlay(`🎉 ${winner} wins!`), 420);
    return;
  }

  // Check for a draw
  if (isBoardFull()) {
    gameOver = true;
    scores.draw++;
    updateScoreboard();
    setTimeout(() => showOverlay("It's a draw! 🤝"), 420);
    return;
  }

  // Switch turns
  currentMark = currentMark === 'X' ? 'O' : 'X';
  updateIndicator();
}

// ── Scoreboard ─────────────────────────────────────────────────────────────

function updateScoreboard() {
  scoreX.textContent    = scores.X;
  scoreO.textContent    = scores.O;
  scoreDraw.textContent = scores.draw;
}

// ── Reset / restart ────────────────────────────────────────────────────────

function resetGame() {
  board       = Array(9).fill(null);
  currentMark = 'X';
  gameOver    = false;

  cells.forEach(cell => {
    cell.textContent = '';
    cell.className   = 'cell';   // removes x / o / winner classes
    cell.disabled    = false;
  });

  overlay.classList.add('hidden');
  updateIndicator();
}

// ── Event listeners ────────────────────────────────────────────────────────

cells.forEach(cell => cell.addEventListener('click', handleCellClick));
restartBtn.addEventListener('click', resetGame);
resetScoresBtn.addEventListener('click', () => {
  scores.X = scores.O = scores.draw = 0;
  updateScoreboard();
});

// ── Kick off ───────────────────────────────────────────────────────────────
updateIndicator();
