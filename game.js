'use strict';

// ── Constants ──────────────────────────────────────────────────────────────
const WINNING_LINES = [
  [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
  [0, 3, 6], [1, 4, 7], [2, 5, 8], // cols
  [0, 4, 8], [2, 4, 6],            // diagonals
];

// ── State ──────────────────────────────────────────────────────────────────
let board        = Array(9).fill(null); // null | 'X' | 'O'
let currentPlayer = 'X';               // whose turn it is
let gameActive   = true;
let scores       = { X: 0, O: 0 };

// ── DOM refs ───────────────────────────────────────────────────────────────
const cells        = document.querySelectorAll('.cell');
const statusEl     = document.getElementById('status');
const scoreXEl     = document.getElementById('score-x');
const scoreOEl     = document.getElementById('score-o');
const cardXEl      = document.getElementById('card-x');
const cardOEl      = document.getElementById('card-o');
const btnRestart   = document.getElementById('btn-restart');
const btnResetScores = document.getElementById('btn-reset-scores');

// ── Helpers ────────────────────────────────────────────────────────────────
function checkWinner() {
  for (const [a, b, c] of WINNING_LINES) {
    if (board[a] && board[a] === board[b] && board[a] === board[c]) {
      return { winner: board[a], line: [a, b, c] };
    }
  }
  if (board.every(cell => cell !== null)) return { winner: null, line: [] }; // draw
  return null; // game continues
}

function setStatus(text, cssClass) {
  statusEl.textContent = text;
  statusEl.className   = cssClass;
}

function highlightActiveCard() {
  cardXEl.classList.toggle('active', currentPlayer === 'X');
  cardOEl.classList.toggle('active', currentPlayer === 'O');
}

function renderBoard() {
  cells.forEach((cell, i) => {
    const val = board[i];
    cell.textContent = val ?? '';
    cell.className   = 'cell' + (val ? ` ${val.toLowerCase()} taken` : '');
    if (!gameActive) cell.classList.add('game-over');
  });
}

// ── Core game logic ────────────────────────────────────────────────────────
function handleCellClick(index) {
  if (!gameActive || board[index] !== null) return;

  board[index] = currentPlayer;
  renderBoard();

  const result = checkWinner();

  if (result) {
    gameActive = false;

    if (result.winner) {
      // Highlight winning cells
      result.line.forEach(i => cells[i].classList.add('winning'));

      scores[result.winner]++;
      scoreXEl.textContent = scores.X;
      scoreOEl.textContent = scores.O;

      const name = result.winner === 'X' ? 'Player 1 (X)' : 'Player 2 (O)';
      setStatus(`🎉 ${name} wins!`, 'winner');
    } else {
      setStatus("It's a draw!", 'draw');
    }

    // Deactivate both cards
    cardXEl.classList.remove('active');
    cardOEl.classList.remove('active');
    return;
  }

  // Switch turn
  currentPlayer = currentPlayer === 'X' ? 'O' : 'X';
  highlightActiveCard();
  const name = currentPlayer === 'X' ? 'Player 1 (X)' : 'Player 2 (O)';
  setStatus(`${name}'s turn`, currentPlayer === 'X' ? 'x-turn' : 'o-turn');
}

function restartGame() {
  board         = Array(9).fill(null);
  currentPlayer = 'X';
  gameActive    = true;

  renderBoard();
  highlightActiveCard();
  setStatus("Player 1 (X)'s turn", 'x-turn');
}

function resetScores() {
  scores = { X: 0, O: 0 };
  scoreXEl.textContent = 0;
  scoreOEl.textContent = 0;
  restartGame();
}

// ── Event listeners ────────────────────────────────────────────────────────
cells.forEach((cell, i) => {
  cell.addEventListener('click', () => handleCellClick(i));
});

btnRestart.addEventListener('click', restartGame);
btnResetScores.addEventListener('click', resetScores);

// ── Init ───────────────────────────────────────────────────────────────────
restartGame();
