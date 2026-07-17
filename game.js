/**
 * Tic Tac Toe — two-player, same browser
 * Player X always goes first each new game.
 */

(() => {
  // ── Constants ──────────────────────────────────────────────
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

  // ── State ──────────────────────────────────────────────────
  let board        = Array(9).fill(null); // null | 'X' | 'O'
  let currentPlayer = 'X';
  let gameOver      = false;
  let scores        = { X: 0, O: 0, draws: 0 };

  // ── DOM refs ───────────────────────────────────────────────
  const cells       = document.querySelectorAll('.cell');
  const statusText  = document.getElementById('status-text');
  const statusBanner = document.getElementById('status-banner');
  const restartBtn  = document.getElementById('restart-btn');
  const winsX       = document.getElementById('wins-x');
  const winsO       = document.getElementById('wins-o');
  const drawsEl     = document.getElementById('draws');
  const scoreX      = document.getElementById('score-x');
  const scoreO      = document.getElementById('score-o');

  // ── Helpers ────────────────────────────────────────────────

  /** Update the status banner text and colour class. */
  function setStatus(html, modifier) {
    statusText.innerHTML = html;
    statusBanner.className = 'status-banner ' + (modifier || '');
  }

  /** Highlight the active player's score card. */
  function updateScoreHighlight() {
    scoreX.classList.toggle('active-x', currentPlayer === 'X' && !gameOver);
    scoreO.classList.toggle('active-o', currentPlayer === 'O' && !gameOver);
  }

  /** Refresh the score display. */
  function renderScores() {
    winsX.textContent  = scores.X;
    winsO.textContent  = scores.O;
    drawsEl.textContent = scores.draws;
  }

  /** Check for a winner; returns the winning combo array or null. */
  function checkWinner() {
    for (const combo of WINNING_COMBOS) {
      const [a, b, c] = combo;
      if (board[a] && board[a] === board[b] && board[a] === board[c]) {
        return combo;
      }
    }
    return null;
  }

  /** Check whether all cells are filled (draw). */
  function isBoardFull() {
    return board.every(cell => cell !== null);
  }

  // ── Core logic ─────────────────────────────────────────────

  function handleCellClick(e) {
    const idx = parseInt(e.currentTarget.dataset.index, 10);

    // Ignore clicks on filled cells or after game ends
    if (board[idx] || gameOver) return;

    // Place the mark
    board[idx] = currentPlayer;
    const cell = cells[idx];
    cell.textContent = currentPlayer;
    cell.classList.add(currentPlayer.toLowerCase());
    cell.disabled = true;

    // Check result
    const winCombo = checkWinner();

    if (winCombo) {
      // Highlight winning cells
      winCombo.forEach(i => cells[i].classList.add('winning'));

      scores[currentPlayer]++;
      renderScores();
      gameOver = true;

      const playerLabel = currentPlayer === 'X'
        ? '<strong style="color:#4fc3f7">X</strong>'
        : '<strong style="color:#ef9a9a">O</strong>';
      setStatus(`🎉 Player ${playerLabel} wins!`, 'winner');

      // Disable all remaining cells
      cells.forEach(c => { c.disabled = true; });
      scoreX.classList.remove('active-x');
      scoreO.classList.remove('active-o');

    } else if (isBoardFull()) {
      scores.draws++;
      renderScores();
      gameOver = true;
      setStatus("It's a <strong>draw</strong>! 🤝", 'draw');
      scoreX.classList.remove('active-x');
      scoreO.classList.remove('active-o');

    } else {
      // Switch player
      currentPlayer = currentPlayer === 'X' ? 'O' : 'X';
      const nextLabel = currentPlayer === 'X'
        ? '<strong style="color:#4fc3f7">X</strong>'
        : '<strong style="color:#ef9a9a">O</strong>';
      setStatus(`Player ${nextLabel}'s turn`, currentPlayer === 'X' ? 'turn-x' : 'turn-o');
      updateScoreHighlight();
    }
  }

  function restartGame() {
    board         = Array(9).fill(null);
    currentPlayer = 'X';
    gameOver      = false;

    cells.forEach(cell => {
      cell.textContent = '';
      cell.className   = 'cell';   // strip x / o / winning classes
      cell.disabled    = false;
    });

    setStatus('Player <strong style="color:#4fc3f7">X</strong>\'s turn', 'turn-x');
    updateScoreHighlight();
  }

  // ── Event listeners ────────────────────────────────────────
  cells.forEach(cell => cell.addEventListener('click', handleCellClick));
  restartBtn.addEventListener('click', restartGame);

  // ── Init ───────────────────────────────────────────────────
  setStatus('Player <strong style="color:#4fc3f7">X</strong>\'s turn', 'turn-x');
  updateScoreHighlight();
  renderScores();

})();
