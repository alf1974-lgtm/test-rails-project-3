/**
 * Tic Tac Toe – Two-player, same browser
 * Player 1 = X  |  Player 2 = O
 */

// ── State ──────────────────────────────────────────────────────────────────
const state = {
  board: Array(9).fill(null),   // null | 'X' | 'O'
  currentPlayer: 'X',           // whose turn it is
  gameOver: false,
  scores: { X: 0, O: 0, draw: 0 },
};

// All eight winning combinations (indices into the board array)
const WIN_COMBOS = [
  [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
  [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
  [0, 4, 8], [2, 4, 6],             // diagonals
];

// ── DOM references ─────────────────────────────────────────────────────────
const cells       = document.querySelectorAll('.cell');
const statusText  = document.getElementById('status-text');
const turnToken   = document.getElementById('turn-token');
const overlay     = document.getElementById('overlay');
const overlayIcon = document.getElementById('overlay-icon');
const overlayMsg  = document.getElementById('overlay-message');
const btnPlayAgain = document.getElementById('btn-play-again');
const btnReset    = document.getElementById('btn-reset');
const winsXEl     = document.getElementById('wins-x');
const winsOEl     = document.getElementById('wins-o');
const drawsEl     = document.getElementById('draws');
const scoreX      = document.getElementById('score-x');
const scoreO      = document.getElementById('score-o');

// ── Helpers ────────────────────────────────────────────────────────────────

/** Returns the winning combo array if `player` has won, otherwise null. */
function getWinningCombo(board, player) {
  return WIN_COMBOS.find(combo =>
    combo.every(idx => board[idx] === player)
  ) ?? null;
}

/** Returns true when all cells are filled. */
function isBoardFull(board) {
  return board.every(cell => cell !== null);
}

// ── Rendering ──────────────────────────────────────────────────────────────

function renderBoard() {
  cells.forEach((cell, idx) => {
    const value = state.board[idx];
    cell.textContent = value ?? '';
    cell.className = 'cell'; // reset classes
    if (value) {
      cell.classList.add(value.toLowerCase());
      cell.disabled = true;
    } else {
      cell.disabled = state.gameOver;
    }
  });
}

function renderStatus() {
  const player = state.currentPlayer;
  const playerName = player === 'X' ? 'Player 1' : 'Player 2';

  turnToken.textContent = player;
  turnToken.className = `turn-token ${player.toLowerCase()}`;
  statusText.textContent = `${playerName}'s turn`;

  // Highlight the active score card
  scoreX.classList.toggle('active-player', player === 'X' && !state.gameOver);
  scoreO.classList.toggle('active-player', player === 'O' && !state.gameOver);
}

function renderScores() {
  winsXEl.textContent = state.scores.X;
  winsOEl.textContent = state.scores.O;
  drawsEl.textContent = state.scores.draw;
}

function showOverlay(icon, message) {
  overlayIcon.textContent = icon;
  overlayMsg.textContent  = message;
  overlay.classList.remove('hidden');
}

// ── Game logic ─────────────────────────────────────────────────────────────

function handleCellClick(event) {
  const idx = parseInt(event.currentTarget.dataset.index, 10);

  // Guard: ignore if cell taken or game over
  if (state.board[idx] !== null || state.gameOver) return;

  // Place the mark
  state.board[idx] = state.currentPlayer;

  // Animate the played cell
  const cell = cells[idx];
  cell.textContent = state.currentPlayer;
  cell.classList.add(state.currentPlayer.toLowerCase(), 'played');
  cell.disabled = true;

  // Check for a win
  const winCombo = getWinningCombo(state.board, state.currentPlayer);
  if (winCombo) {
    state.gameOver = true;
    state.scores[state.currentPlayer]++;
    renderScores();

    // Highlight winning cells
    winCombo.forEach(i => cells[i].classList.add('winner'));

    // Deactivate score-card highlights
    scoreX.classList.remove('active-player');
    scoreO.classList.remove('active-player');

    const winner = state.currentPlayer === 'X' ? 'Player 1' : 'Player 2';
    const icon   = state.currentPlayer === 'X' ? '🎉' : '🏆';
    setTimeout(() => showOverlay(icon, `${winner} (${state.currentPlayer}) wins!`), 500);
    return;
  }

  // Check for a draw
  if (isBoardFull(state.board)) {
    state.gameOver = true;
    state.scores.draw++;
    renderScores();
    scoreX.classList.remove('active-player');
    scoreO.classList.remove('active-player');
    setTimeout(() => showOverlay('🤝', "It's a draw!"), 300);
    return;
  }

  // Switch player
  state.currentPlayer = state.currentPlayer === 'X' ? 'O' : 'X';
  renderStatus();
}

function startNewRound() {
  state.board         = Array(9).fill(null);
  state.currentPlayer = 'X';
  state.gameOver      = false;

  overlay.classList.add('hidden');
  renderBoard();
  renderStatus();
}

function resetScores() {
  state.scores = { X: 0, O: 0, draw: 0 };
  renderScores();
  startNewRound();
}

// ── Event listeners ────────────────────────────────────────────────────────

cells.forEach(cell => cell.addEventListener('click', handleCellClick));
btnPlayAgain.addEventListener('click', startNewRound);
btnReset.addEventListener('click', resetScores);

// ── Initial render ─────────────────────────────────────────────────────────
renderBoard();
renderStatus();
renderScores();
