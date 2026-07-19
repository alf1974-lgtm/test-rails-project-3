// Game state
let gameBoard = ['', '', '', '', '', '', '', '', ''];
let currentPlayer = 'X';
let gameActive = true;

// Winning combinations
const winningCombinations = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
];

// DOM elements
const cells = document.querySelectorAll('.cell');
const playerSymbolDisplay = document.getElementById('player-symbol');
const gameStatusDisplay = document.getElementById('game-status');
const resetButton = document.getElementById('reset-btn');

// Initialize event listeners
cells.forEach(cell => {
    cell.addEventListener('click', handleCellClick);
});

resetButton.addEventListener('click', resetGame);

// Handle cell click
function handleCellClick(e) {
    const cell = e.target;
    const index = cell.getAttribute('data-index');

    // Check if cell is already taken or game is over
    if (gameBoard[index] !== '' || !gameActive) {
        return;
    }

    // Update game board
    gameBoard[index] = currentPlayer;

    // Update cell display
    cell.textContent = currentPlayer;
    cell.classList.add('taken');
    cell.classList.add(currentPlayer.toLowerCase());

    // Check for win or draw
    checkGameStatus();

    // Switch player
    if (gameActive) {
        currentPlayer = currentPlayer === 'X' ? 'O' : 'X';
        updatePlayerDisplay();
    }
}

// Check game status
function checkGameStatus() {
    let gameWon = false;

    for (let i = 0; i < winningCombinations.length; i++) {
        const [a, b, c] = winningCombinations[i];
        if (gameBoard[a] === '' || gameBoard[b] === '' || gameBoard[c] === '') {
            continue;
        }
        if (gameBoard[a] === gameBoard[b] && gameBoard[b] === gameBoard[c]) {
            gameWon = true;
            break;
        }
    }

    if (gameWon) {
        gameStatusDisplay.textContent = `🎉 Player ${currentPlayer} Wins! 🎉`;
        gameActive = false;
        return;
    }

    // Check for draw
    if (!gameBoard.includes('')) {
        gameStatusDisplay.textContent = "It's a Draw!";
        gameActive = false;
        return;
    }

    // Game continues
    gameStatusDisplay.textContent = '';
}

// Update player display
function updatePlayerDisplay() {
    playerSymbolDisplay.textContent = currentPlayer;
}

// Reset game
function resetGame() {
    gameBoard = ['', '', '', '', '', '', '', '', ''];
    currentPlayer = 'X';
    gameActive = true;
    gameStatusDisplay.textContent = '';
    playerSymbolDisplay.textContent = 'X';

    cells.forEach(cell => {
        cell.textContent = '';
        cell.classList.remove('taken', 'x', 'o');
    });
}
