'use strict';

// ── Constants ──────────────────────────────────────────────────────────────
const WINNING_LINES = [
  [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
  [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
  [0, 4, 8], [2, 4, 6],             // diagonals
];

// ── State ──────────────────────────────────────────────────────────────────
let board        = Array(9).fill(null); // null | 'X' | 'O'
let currentPlayer = 'X';               // whose turn it is
let gameOver      = false;
let scores        = { X: 0, O: 0, draws: 0 };

// ── DOM refs ───────────────────────────────────────────────────────────────
const cells          = document.querySelectorAll('.cell');
const statusEl       = document.getElementById('status');
const scoreX         = document.getElementById('score-x');
const scoreO         = document.getElementById('score-o');
const scoreDraws     = document.getElementById('score-draws');
const btnRestart     = document.getElementById('btn-restart');
const btnResetScores = document.getElementById('btn-reset-scores');

// ── Helpers ────────────────────────────────────────────────────────────────

/** Update the status banner text and colour class. */
function setStatus(text, cssClass) {
  statusEl.textContent = text;
  statusEl.className   = cssClass;
}

/** Refresh the three score counters. */
function renderScores() {
  scoreX.textContent     = scores.X;
  scoreO.textContent     = scores.O;
  scoreDraws.textContent = scores.draws;
}

/** Check for a winner; returns { winner, line } or null. */
function checkWinner() {
  for (const line of WINNING_LINES) {
    const [a, b, c] = line;
    if (board[a] && board[a] === board[b] && board[a] === board[c]) {
      return { winner: board[a], line };
    }
  }
  return null;
}

/** Highlight the three winning cells. */
function highlightWinningLine(line) {
  line.forEach(idx => cells[idx].classList.add('winning'));
}

// ── Core game logic ────────────────────────────────────────────────────────

function handleCellClick(event) {
  const cell  = event.currentTarget;
  const index = parseInt(cell.dataset.index, 10);

  // Ignore clicks on already-filled cells or after game ends
  if (board[index] || gameOver) return;

  // Place the mark
  board[index]      = currentPlayer;
  cell.classList.add('taken', currentPlayer.toLowerCase());
  cell.innerHTML    = `<span>${currentPlayer}</span>`;

  // Check for win
  const result = checkWinner();
  if (result) {
    gameOver = true;
    scores[result.winner]++;
    renderScores();
    highlightWinningLine(result.line);
    setStatus(`🎉 Player ${result.winner} wins!`, 'winner');
    return;
  }

  // Check for draw
  if (board.every(cell => cell !== null)) {
    gameOver = true;
    scores.draws++;
    renderScores();
    setStatus("It's a draw! 🤝", 'draw');
    return;
  }

  // Switch player
  currentPlayer = currentPlayer === 'X' ? 'O' : 'X';
  setStatus(`Player ${currentPlayer}'s turn`, currentPlayer === 'X' ? 'x-turn' : 'o-turn');
}

/** Reset the board for a new round (scores are preserved). */
function restartGame() {
  board         = Array(9).fill(null);
  currentPlayer = 'X';
  gameOver      = false;

  cells.forEach(cell => {
    cell.className = 'cell';   // wipe all state classes
    cell.innerHTML = '';
  });

  setStatus("Player X's turn", 'x-turn');
}

/** Reset scores AND restart. */
function resetScores() {
  scores = { X: 0, O: 0, draws: 0 };
  renderScores();
  restartGame();
}

// ── Event listeners ────────────────────────────────────────────────────────
cells.forEach(cell => cell.addEventListener('click', handleCellClick));
btnRestart.addEventListener('click', restartGame);
btnResetScores.addEventListener('click', resetScores);

// ── Init ───────────────────────────────────────────────────────────────────
renderScores();
setStatus("Player X's turn", 'x-turn');
