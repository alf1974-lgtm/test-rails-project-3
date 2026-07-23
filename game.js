/**
 * Tic Tac Toe — two players, one browser
 * Player X always goes first each round.
 */

// ── Constants ──────────────────────────────────────────────────────────────

const WINNING_COMBOS = [
  [0, 1, 2], // top row
  [3, 4, 5], // middle row
  [6, 7, 8], // bottom row
  [0, 3, 6], // left col
  [1, 4, 7], // middle col
  [2, 5, 8], // right col
  [0, 4, 8], // diagonal ↘
  [2, 4, 6], // diagonal ↙
];

// ── State ──────────────────────────────────────────────────────────────────

let board        = Array(9).fill(null); // null | 'X' | 'O'
let currentPlayer = 'X';
let gameOver     = false;
let scores       = { X: 0, O: 0, draws: 0 };

// ── DOM refs ───────────────────────────────────────────────────────────────

const cells         = document.querySelectorAll('.cell');
const statusText    = document.getElementById('status-text');
const currentMarker = document.getElementById('current-marker');
const overlay       = document.getElementById('overlay');
const resultIcon    = document.getElementById('result-icon');
const resultText    = document.getElementById('result-text');
const playAgainBtn  = document.getElementById('play-again-btn');
const resetBtn      = document.getElementById('reset-btn');
const winsX         = document.getElementById('wins-x');
const winsO         = document.getElementById('wins-o');
const drawsEl       = document.getElementById('draws');
const scoreX        = document.getElementById('score-x');
const scoreO        = document.getElementById('score-o');

// ── Core logic ─────────────────────────────────────────────────────────────

/**
 * Handle a cell click.
 */
function handleCellClick(e) {
  const index = parseInt(e.currentTarget.dataset.index, 10);

  // Ignore if cell already taken or game is over
  if (board[index] || gameOver) return;

  // Place the mark
  board[index] = currentPlayer;
  renderCell(e.currentTarget, currentPlayer);

  // Check result
  const winningCombo = getWinningCombo();

  if (winningCombo) {
    highlightWinners(winningCombo);
    endGame(false);
  } else if (board.every(Boolean)) {
    endGame(true);
  } else {
    switchPlayer();
  }
}

/**
 * Render a mark inside a cell with a pop animation.
 */
function renderCell(cell, player) {
  cell.textContent = player;
  cell.classList.add('taken', player === 'X' ? 'x-cell' : 'o-cell', 'pop');
  // Remove pop class after animation so it can re-trigger if needed
  cell.addEventListener('animationend', () => cell.classList.remove('pop'), { once: true });
}

/**
 * Switch the active player and update the UI.
 */
function switchPlayer() {
  currentPlayer = currentPlayer === 'X' ? 'O' : 'X';
  updateStatusBar();
  updateActiveScore();
}

/**
 * Return the winning combo array, or null if none.
 */
function getWinningCombo() {
  return WINNING_COMBOS.find(
    ([a, b, c]) => board[a] && board[a] === board[b] && board[a] === board[c]
  ) ?? null;
}

/**
 * Highlight the three winning cells.
 */
function highlightWinners(combo) {
  combo.forEach(i => cells[i].classList.add('winning'));
}

/**
 * End the game: update scores and show the overlay.
 */
function endGame(isDraw) {
  gameOver = true;

  if (isDraw) {
    scores.draws++;
    drawsEl.textContent = scores.draws;
    resultIcon.textContent = '🤝';
    resultText.textContent = "It's a draw!";
  } else {
    scores[currentPlayer]++;
    if (currentPlayer === 'X') {
      winsX.textContent = scores.X;
    } else {
      winsO.textContent = scores.O;
    }
    resultIcon.textContent = currentPlayer === 'X' ? '🎉' : '🏆';
    resultText.textContent = `Player ${currentPlayer} wins!`;
  }

  // Small delay so the winning highlight is visible before overlay appears
  setTimeout(() => overlay.classList.remove('hidden'), 600);
}

// ── UI helpers ─────────────────────────────────────────────────────────────

/**
 * Update the "X's turn / O's turn" status bar.
 */
function updateStatusBar() {
  currentMarker.textContent = currentPlayer;
  currentMarker.className   = `marker ${currentPlayer.toLowerCase()}`;
  statusText.textContent    = "'s turn";
}

/**
 * Highlight the active player's score card.
 */
function updateActiveScore() {
  scoreX.classList.toggle('active', currentPlayer === 'X');
  scoreO.classList.toggle('active', currentPlayer === 'O');
}

// ── Game reset ─────────────────────────────────────────────────────────────

/**
 * Start a fresh round (keep scores).
 */
function newRound() {
  board         = Array(9).fill(null);
  currentPlayer = 'X';
  gameOver      = false;

  cells.forEach(cell => {
    cell.textContent = '';
    cell.className   = 'cell'; // strip all state classes
  });

  overlay.classList.add('hidden');
  updateStatusBar();
  updateActiveScore();
}

/**
 * Reset everything including scores.
 */
function resetAll() {
  scores = { X: 0, O: 0, draws: 0 };
  winsX.textContent  = 0;
  winsO.textContent  = 0;
  drawsEl.textContent = 0;
  newRound();
}

// ── Event listeners ────────────────────────────────────────────────────────

cells.forEach(cell => cell.addEventListener('click', handleCellClick));
playAgainBtn.addEventListener('click', newRound);
resetBtn.addEventListener('click', resetAll);

// ── Init ───────────────────────────────────────────────────────────────────

updateStatusBar();
updateActiveScore();
