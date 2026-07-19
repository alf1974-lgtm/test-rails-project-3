/**
 * Tic Tac Toe — two players, same browser
 * Player X always goes first; players alternate after each move.
 */

(function () {
  'use strict';

  // ── Winning combinations (indices into the 9-cell board) ──────────────────
  const WIN_COMBOS = [
    [0, 1, 2], // top row
    [3, 4, 5], // middle row
    [6, 7, 8], // bottom row
    [0, 3, 6], // left column
    [1, 4, 7], // middle column
    [2, 5, 8], // right column
    [0, 4, 8], // diagonal ↘
    [2, 4, 6], // diagonal ↙
  ];

  // ── State ─────────────────────────────────────────────────────────────────
  let board          = Array(9).fill(null); // null | 'X' | 'O'
  let currentPlayer  = 'X';
  let gameOver       = false;
  let scores         = { X: 0, O: 0, draw: 0 };

  // ── DOM refs ──────────────────────────────────────────────────────────────
  const cells          = document.querySelectorAll('.cell');
  const statusBanner   = document.getElementById('status-banner');
  const currentPlayerEl= document.getElementById('current-player');
  const resultMessage  = document.getElementById('result-message');
  const winsXEl        = document.getElementById('wins-x');
  const winsOEl        = document.getElementById('wins-o');
  const drawsEl        = document.getElementById('draws');
  const restartBtn     = document.getElementById('restart-btn');
  const resetScoreBtn  = document.getElementById('reset-score-btn');

  // ── Initialise ────────────────────────────────────────────────────────────
  function init() {
    board         = Array(9).fill(null);
    currentPlayer = 'X';
    gameOver      = false;

    cells.forEach(cell => {
      cell.textContent = '';
      cell.className   = 'cell';
      cell.disabled    = false;
    });

    resultMessage.textContent = '';
    resultMessage.classList.add('hidden');

    updateStatusBanner();
  }

  // ── Handle a cell click ───────────────────────────────────────────────────
  function handleCellClick(e) {
    const cell  = e.currentTarget;
    const index = parseInt(cell.dataset.index, 10);

    if (gameOver || board[index] !== null) return;

    // Place the mark
    board[index]     = currentPlayer;
    cell.textContent = currentPlayer;
    cell.classList.add(currentPlayer.toLowerCase());
    cell.disabled    = true;

    // Check outcome
    const winCombo = getWinCombo();
    if (winCombo) {
      highlightWinners(winCombo);
      endGame('win');
    } else if (board.every(v => v !== null)) {
      endGame('draw');
    } else {
      // Switch player
      currentPlayer = currentPlayer === 'X' ? 'O' : 'X';
      updateStatusBanner();
    }
  }

  // ── Check for a winning combination ──────────────────────────────────────
  function getWinCombo() {
    return WIN_COMBOS.find(([a, b, c]) =>
      board[a] !== null &&
      board[a] === board[b] &&
      board[b] === board[c]
    ) || null;
  }

  // ── Highlight the three winning cells ────────────────────────────────────
  function highlightWinners(combo) {
    combo.forEach(i => cells[i].classList.add('winning'));
  }

  // ── End the game ─────────────────────────────────────────────────────────
  function endGame(outcome) {
    gameOver = true;

    // Disable all remaining cells
    cells.forEach(cell => { cell.disabled = true; });

    if (outcome === 'win') {
      scores[currentPlayer]++;
      updateScoreboard();

      statusBanner.className = 'status-banner winner';
      statusBanner.innerHTML =
        `🏆 Player <span id="current-player">${currentPlayer}</span> wins!`;

      resultMessage.textContent = `Player ${currentPlayer} wins! 🎉`;
      resultMessage.style.color = currentPlayer === 'X' ? '#e94560' : '#4fc3f7';
    } else {
      scores.draw++;
      updateScoreboard();

      statusBanner.className = 'status-banner draw';
      statusBanner.innerHTML = `🤝 It's a draw!`;

      resultMessage.textContent = "It's a draw! 🤝";
      resultMessage.style.color = '#ffd54f';
    }

    resultMessage.classList.remove('hidden');
  }

  // ── Update the "Player X's turn" banner ──────────────────────────────────
  function updateStatusBanner() {
    statusBanner.className = `status-banner ${currentPlayer === 'X' ? 'x-turn' : 'o-turn'}`;
    statusBanner.innerHTML =
      `Player <span id="current-player">${currentPlayer}</span>'s turn`;
  }

  // ── Refresh score display ─────────────────────────────────────────────────
  function updateScoreboard() {
    winsXEl.textContent = scores.X;
    winsOEl.textContent = scores.O;
    drawsEl.textContent = scores.draw;
  }

  // ── Event listeners ───────────────────────────────────────────────────────
  cells.forEach(cell => cell.addEventListener('click', handleCellClick));

  restartBtn.addEventListener('click', init);

  resetScoreBtn.addEventListener('click', () => {
    scores = { X: 0, O: 0, draw: 0 };
    updateScoreboard();
    init();
  });

  // ── Kick off ──────────────────────────────────────────────────────────────
  init();

})();
