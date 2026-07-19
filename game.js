/**
 * Tic Tac Toe — two players, same browser
 * Player X always goes first in each round.
 */

'use strict';

// ── Constants ──────────────────────────────────────────────────────────────
const WINNING_LINES = [
  [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
  [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
  [0, 4, 8], [2, 4, 6],             // diagonals
];

// ── State ──────────────────────────────────────────────────────────────────
let board         = Array(9).fill(null); // null | 'X' | 'O'
let currentPlayer = 'X';                // whose turn it is
let gameOver      = false;
let scores        = { X: 0, O: 0 };

// ── DOM refs ───────────────────────────────────────────────────────────────
const cells          = document.querySelectorAll('.cell');
const statusEl       = document.getElementById('status');
const scoreXEl       = document.getElementById('score-x');
const scoreOEl       = document.getElementById('score-o');
const cardXEl        = document.getElementById('card-x');
const cardOEl        = document.getElementById('card-o');
const btnRestart     = document.getElementById('btn-restart');
const btnResetScores = document.getElementById('btn-reset-scores');

// ── Helpers ────────────────────────────────────────────────────────────────

/**
 * Returns:
 *   { winner: 'X'|'O', line: [i,j,k] }  — someone won
 *   { winner: null,     line: []      }  — draw (board full, no winner)
 *   null                                 — game still in progress
 */
function checkWinner() {
  for (const [a, b, c] of WINNING_LINES) {
    if (board[a] && board[a] === board[b] && board[a] === board[c]) {
      return { winner: board[a], line: [a, b, c] };
    }
  }
  if (board.every(function (cell) { return cell !== null; })) {
    return { winner: null, line: [] }; // draw
  }
  return null; // still going
}

function updateActiveCard() {
  cardXEl.classList.toggle('active-player', currentPlayer === 'X');
  cardOEl.classList.toggle('active-player', currentPlayer === 'O');
}

function setStatus(text, cls) {
  statusEl.textContent = text;
  statusEl.className   = cls || '';
}

// ── Core logic ─────────────────────────────────────────────────────────────

function handleCellClick(index) {
  if (gameOver || board[index]) return;

  // Place the mark
  board[index] = currentPlayer;
  var cell = cells[index];
  cell.textContent = currentPlayer;
  cell.classList.add('taken', currentPlayer.toLowerCase());

  // Check result
  var result = checkWinner();

  if (result) {
    gameOver = true;

    if (result.winner) {
      // Highlight winning cells
      result.line.forEach(function (i) { cells[i].classList.add('winning'); });

      scores[result.winner]++;
      scoreXEl.textContent = scores.X;
      scoreOEl.textContent = scores.O;

      var winnerName = result.winner === 'X' ? 'Player X' : 'Player O';
      setStatus(
        '\uD83C\uDF89 ' + winnerName + ' wins! Press "New Round" to play again.',
        result.winner === 'X' ? 'winner-x' : 'winner-o'
      );
    } else {
      setStatus("It's a draw! Press \"New Round\" to play again.", 'draw');
    }

    updateActiveCard();
    return;
  }

  // Switch player
  currentPlayer = currentPlayer === 'X' ? 'O' : 'X';
  updateActiveCard();
  var nextName = currentPlayer === 'X' ? 'Player X' : 'Player O';
  setStatus(nextName + "'s turn (" + currentPlayer + ')');
}

function startNewRound() {
  board         = Array(9).fill(null);
  currentPlayer = 'X';
  gameOver      = false;

  cells.forEach(function (cell) {
    cell.textContent = '';
    cell.className   = 'cell'; // strip all state classes
  });

  updateActiveCard();
  setStatus("Player X's turn (X)");
}

function resetScores() {
  scores = { X: 0, O: 0 };
  scoreXEl.textContent = 0;
  scoreOEl.textContent = 0;
  startNewRound();
}

// ── Event listeners ────────────────────────────────────────────────────────

cells.forEach(function (cell, index) {
  cell.addEventListener('click', function () { handleCellClick(index); });
});

btnRestart.addEventListener('click', startNewRound);
btnResetScores.addEventListener('click', resetScores);

// ── Init ───────────────────────────────────────────────────────────────────
startNewRound();
