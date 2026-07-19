/**
 * Tic Tac Toe — two players, same browser
 * Player 1 = X  |  Player 2 = O
 * Players alternate turns; X always goes first each round.
 */

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
const cells         = document.querySelectorAll('.cell');
const statusText    = document.getElementById('status-text');
const currentMarker = document.getElementById('current-marker');
const overlay       = document.getElementById('overlay');
const overlayIcon   = document.getElementById('overlay-icon');
const overlayMsg    = document.getElementById('overlay-message');
const nextRoundBtn  = document.getElementById('next-round-btn');
const resetBtn      = document.getElementById('reset-btn');
const winsXEl       = document.getElementById('wins-x');
const winsOEl       = document.getElementById('wins-o');
const drawsEl       = document.getElementById('draws');
const scoreX        = document.getElementById('score-x');
const scoreO        = document.getElementById('score-o');

// ── Game state ─────────────────────────────────────────────────────────────
let board        = Array(9).fill(null); // null | 'X' | 'O'
let currentPlayer = 'X';               // whose turn it is
let gameOver     = false;
let scores       = { X: 0, O: 0, draw: 0 };

// ── Helpers ────────────────────────────────────────────────────────────────

/** Return the winning combo array if `player` has won, otherwise null. */
function getWinningCombo(player) {
  return WIN_COMBOS.find(combo =>
    combo.every(i => board[i] === player)
  ) ?? null;
}

/** Check whether all cells are filled (used for draw detection). */
function isBoardFull() {
  return board.every(cell => cell !== null);
}

/** Update the status bar to reflect whose turn it is. */
function updateStatusBar() {
  const isX = currentPlayer === 'X';
  currentMarker.textContent = currentPlayer;
  currentMarker.className   = 'marker' + (isX ? '' : ' o');
  statusText.textContent    = isX ? "Player 1's turn" : "Player 2's turn";

  // Highlight the active player's score card
  scoreX.classList.toggle('active-player', isX);
  scoreO.classList.toggle('active-player', !isX);
}

/** Refresh the scoreboard numbers. */
function updateScoreboard() {
  winsXEl.textContent = scores.X;
  winsOEl.textContent = scores.O;
  drawsEl.textContent = scores.draw;
}

// ── Core game logic ────────────────────────────────────────────────────────

function handleCellClick(e) {
  const cell  = e.currentTarget;
  const index = parseInt(cell.dataset.index, 10);

  // Ignore clicks on already-filled cells or after game ends
  if (board[index] !== null || gameOver) return;

  // Place the mark
  board[index]      = currentPlayer;
  cell.textContent  = currentPlayer;
  cell.classList.add('taken', currentPlayer.toLowerCase(), 'pop');

  // Check for a win
  const winCombo = getWinningCombo(currentPlayer);
  if (winCombo) {
    gameOver = true;
    scores[currentPlayer]++;
    updateScoreboard();

    // Highlight winning cells
    winCombo.forEach(i => cells[i].classList.add('winner'));

    // Show overlay after a short delay so the winning cell animation plays
    setTimeout(() => showOverlay('win', currentPlayer), 500);
    return;
  }

  // Check for a draw
  if (isBoardFull()) {
    gameOver = true;
    scores.draw++;
    updateScoreboard();
    setTimeout(() => showOverlay('draw', null), 500);
    return;
  }

  // Switch player
  currentPlayer = currentPlayer === 'X' ? 'O' : 'X';
  updateStatusBar();
}

// ── Overlay ────────────────────────────────────────────────────────────────

function showOverlay(result, winner) {
  overlay.classList.remove('hidden');

  if (result === 'win') {
    const playerName = winner === 'X' ? 'Player 1 (X)' : 'Player 2 (O)';
    overlayIcon.textContent = winner === 'X' ? '🎉' : '🏆';
    overlayMsg.textContent  = `${playerName} wins!`;
  } else {
    overlayIcon.textContent = '🤝';
    overlayMsg.textContent  = "It's a draw!";
  }
}

function hideOverlay() {
  overlay.classList.add('hidden');
}

// ── Round / score reset ────────────────────────────────────────────────────

/** Start a fresh round (keep scores). */
function startNewRound() {
  board         = Array(9).fill(null);
  currentPlayer = 'X';
  gameOver      = false;

  cells.forEach(cell => {
    cell.textContent = '';
    cell.className   = 'cell'; // strip all state classes
  });

  hideOverlay();
  updateStatusBar();
}

/** Reset everything including scores. */
function resetAll() {
  scores = { X: 0, O: 0, draw: 0 };
  updateScoreboard();
  startNewRound();
}

// ── Event listeners ────────────────────────────────────────────────────────

cells.forEach(cell => cell.addEventListener('click', handleCellClick));
nextRoundBtn.addEventListener('click', startNewRound);
resetBtn.addEventListener('click', resetAll);

// ── Init ───────────────────────────────────────────────────────────────────
updateStatusBar();
updateScoreboard();
