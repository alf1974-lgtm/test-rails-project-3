/**
 * Tic Tac Toe — two players, same browser
 * Player X always goes first each new game.
 */

// ── State ──────────────────────────────────────────────────────────────────
const state = {
  board: Array(9).fill(null),   // null | 'X' | 'O'
  currentPlayer: 'X',
  gameOver: false,
  score: { X: 0, O: 0, draws: 0 },
};

// All possible winning combinations (indices into the board array)
const WIN_COMBOS = [
  [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
  [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
  [0, 4, 8], [2, 4, 6],             // diagonals
];

// ── DOM refs ───────────────────────────────────────────────────────────────
const cells         = document.querySelectorAll('.cell');
const statusBanner  = document.getElementById('status-banner');
const currentPlayerSpan = document.getElementById('current-player');
const resultMessage = document.getElementById('result-message');
const restartBtn    = document.getElementById('restart-btn');
const winsXEl       = document.getElementById('wins-x');
const winsOEl       = document.getElementById('wins-o');
const drawsEl       = document.getElementById('draws');

// ── Core logic ─────────────────────────────────────────────────────────────

/** Return the winning combo indices if `player` has won, otherwise null. */
function getWinningCombo(board, player) {
  return WIN_COMBOS.find(combo =>
    combo.every(idx => board[idx] === player)
  ) ?? null;
}

/** Return true when all cells are filled. */
function isBoardFull(board) {
  return board.every(cell => cell !== null);
}

/** Handle a cell click. */
function handleCellClick(event) {
  const cell  = event.currentTarget;
  const index = parseInt(cell.dataset.index, 10);

  // Ignore if game is over or cell already taken
  if (state.gameOver || state.board[index] !== null) return;

  // Place the mark
  state.board[index] = state.currentPlayer;
  renderCell(cell, state.currentPlayer);

  // Check for win
  const winCombo = getWinningCombo(state.board, state.currentPlayer);
  if (winCombo) {
    endGame('win', winCombo);
    return;
  }

  // Check for draw
  if (isBoardFull(state.board)) {
    endGame('draw');
    return;
  }

  // Switch player
  state.currentPlayer = state.currentPlayer === 'X' ? 'O' : 'X';
  updateStatusBanner();
}

/** Visually mark a cell with the player's symbol. */
function renderCell(cellEl, player) {
  cellEl.textContent = player;
  cellEl.classList.add(player.toLowerCase());
  cellEl.disabled = true;

  // Trigger pop animation (remove then re-add to restart it)
  cellEl.classList.remove('pop');
  void cellEl.offsetWidth; // reflow
  cellEl.classList.add('pop');
}

/** Finish the game — either a win or a draw. */
function endGame(outcome, winCombo = null) {
  state.gameOver = true;

  // Disable all remaining cells
  cells.forEach(c => (c.disabled = true));

  if (outcome === 'win') {
    // Highlight winning cells
    winCombo.forEach(idx => cells[idx].classList.add('winning'));

    // Update score
    state.score[state.currentPlayer]++;
    updateScoreboard();

    // Update UI
    statusBanner.className = 'status-banner winner';
    statusBanner.textContent = `🎉 Player ${state.currentPlayer} wins!`;
    resultMessage.textContent = `Player ${state.currentPlayer} takes the round!`;
  } else {
    // Draw
    state.score.draws++;
    updateScoreboard();

    statusBanner.className = 'status-banner draw';
    statusBanner.textContent = "🤝 It's a draw!";
    resultMessage.textContent = "No winner this time — try again!";
  }

  resultMessage.classList.remove('hidden');
}

/** Reset the board for a new game (scores persist). */
function newGame() {
  state.board.fill(null);
  state.currentPlayer = 'X';
  state.gameOver = false;

  cells.forEach(cell => {
    cell.textContent = '';
    cell.className = 'cell';   // wipe x / o / winning / pop classes
    cell.disabled = false;
  });

  resultMessage.classList.add('hidden');
  resultMessage.textContent = '';
  updateStatusBanner();
}

// ── UI helpers ─────────────────────────────────────────────────────────────

function updateStatusBanner() {
  const p = state.currentPlayer;
  statusBanner.className = `status-banner ${p === 'X' ? 'x-turn' : 'o-turn'}`;
  statusBanner.innerHTML = `Player <span id="current-player">${p}</span>'s turn`;
}

function updateScoreboard() {
  winsXEl.textContent = state.score.X;
  winsOEl.textContent = state.score.O;
  drawsEl.textContent = state.score.draws;
}

// ── Event listeners ────────────────────────────────────────────────────────
cells.forEach(cell => cell.addEventListener('click', handleCellClick));
restartBtn.addEventListener('click', newGame);

// ── Init ───────────────────────────────────────────────────────────────────
updateStatusBanner();
updateScoreboard();
