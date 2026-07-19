// Game state
let gameBoard = ['', '', '', '', '', '', '', '', ''];
let currentPlayer = 'X'; // X for Player 1, O for Player 2
let gameActive = true;
let gameWon = false;

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
const playerDisplay = document.getElementById('playerDisplay');
const gameStatus = document.getElementById('gameStatus');
const resetBtn = document.getElementById('resetBtn');

// Initialize event listeners
cells.forEach(cell => {
    cell.addEventListener('click', handleCellClick);
});

resetBtn.addEventListener('click', resetGame);

// Handle cell click
function handleCellClick(e) {
    const cell = e.target;
    const index = cell.getAttribute('data-index');

    // Check if cell is already filled or game is over
    if (gameBoard[index] !== '' || !gameActive) {
        return;
    }

    // Update game board
    gameBoard[index] = currentPlayer;

    // Update cell display
    cell.textContent = currentPlayer;
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
    let hasWon = false;

    // Check for winning combination
    for (let combination of winningCombinations) {
        const [a, b, c] = combination;
        if (gameBoard[a] !== '' && 
            gameBoard[a] === gameBoard[b] && 
            gameBoard[b] === gameBoard[c]) {
            hasWon = true;
            gameWon = true;
            break;
        }
    }

    if (hasWon) {
        gameActive = false;
        const winner = currentPlayer === 'X' ? 'Player 1' : 'Player 2';
        gameStatus.textContent = `🎉 ${winner} (${currentPlayer}) Wins!`;
        playerDisplay.textContent = `Game Over - ${winner} Wins!`;
        return;
    }

    // Check for draw
    if (gameBoard.every(cell => cell !== '')) {
        gameActive = false;
        gameStatus.textContent = "It's a Draw!";
        playerDisplay.textContent = "Game Over - It's a Draw!";
        return;
    }

    // Game continues
    gameStatus.textContent = '';
}

// Update player display
function updatePlayerDisplay() {
    const playerNum = currentPlayer === 'X' ? '1' : '2';
    playerDisplay.textContent = `Player ${playerNum}'s Turn (${currentPlayer})`;
}

// Reset game
function resetGame() {
    gameBoard = ['', '', '', '', '', '', '', '', ''];
    currentPlayer = 'X';
    gameActive = true;
    gameWon = false;
    gameStatus.textContent = '';

    // Clear all cells
    cells.forEach(cell => {
        cell.textContent = '';
        cell.classList.remove('x', 'o');
    });

    updatePlayerDisplay();
}

// Initialize display
updatePlayerDisplay();
