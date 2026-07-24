/**
 * UI Renderer module
 * Handles all rendering of game board, pieces, and UI elements
 */

class UIRenderer {
    /**
     * Render the main game board with all cells
     * @param {Array} board - The game board
     * @param {Object} currentPiece - The current falling piece
     * @param {number} currentX - Current piece X position
     * @param {number} currentY - Current piece Y position
     */
    static renderBoard(board, currentPiece, currentX, currentY) {
        const boardEl = document.getElementById('gameBoard');
        boardEl.innerHTML = '';

        // Create a copy of the board with the current piece
        const displayBoard = JSON.parse(JSON.stringify(board));

        // Add current piece to display
        for (let row = 0; row < currentPiece.shape.length; row++) {
            for (let col = 0; col < currentPiece.shape[row].length; col++) {
                if (currentPiece.shape[row][col] === 1) {
                    const boardY = currentY + row;
                    const boardX = currentX + col;
                    if (boardY >= 0 && boardY < BOARD_HEIGHT && boardX >= 0 && boardX < BOARD_WIDTH) {
                        displayBoard[boardY][boardX] = {
                            letter: currentPiece.letters[row][col].letter,
                            bonus: currentPiece.letters[row][col].bonus,
                            color: currentPiece.color,
                            isActive: true
                        };
                    }
                }
            }
        }

        // Render all cells
        for (let row = 0; row < BOARD_HEIGHT; row++) {
            for (let col = 0; col < BOARD_WIDTH; col++) {
                const cell = displayBoard[row][col];
                const cellEl = document.createElement('div');
                cellEl.className = 'cell';

                if (cell) {
                    cellEl.classList.add('filled');
                    if (cell.bonus) {
                        cellEl.classList.add(`bonus-${cell.bonus}`);
                        const bonusLabel = document.createElement('div');
                        bonusLabel.className = 'bonus-label';
                        bonusLabel.textContent = cell.bonus.split('-')[0][0].toUpperCase();
                        cellEl.appendChild(bonusLabel);
                    }

                    const letterEl = document.createElement('div');
                    letterEl.className = 'cell-letter';
                    letterEl.textContent = cell.letter;

                    // Set text color based on background for readability
                    if (cell.bonus) {
                        if (cell.bonus.includes('word')) {
                            letterEl.style.color = '#fff';
                        } else {
                            letterEl.style.color = '#000';
                        }
                    } else {
                        letterEl.style.color = '#fff';
                    }

                    cellEl.appendChild(letterEl);
                }

                boardEl.appendChild(cellEl);
            }
        }
    }

    /**
     * Render the next piece preview
     * @param {Object} nextPiece - The next piece to display
     */
    static renderNextPiece(nextPiece) {
        const nextEl = document.getElementById('nextPiece');
        nextEl.innerHTML = '';

        for (let row = 0; row < 4; row++) {
            for (let col = 0; col < 4; col++) {
                const cellEl = document.createElement('div');
                cellEl.className = 'cell';

                if (row < nextPiece.shape.length && col < nextPiece.shape[row].length) {
                    if (nextPiece.shape[row][col] === 1) {
                        cellEl.classList.add('filled');
                        const letterEl = document.createElement('div');
                        letterEl.className = 'cell-letter';
                        letterEl.textContent = nextPiece.letters[row][col].letter;
                        cellEl.appendChild(letterEl);
                    }
                }

                nextEl.appendChild(cellEl);
            }
        }
    }

    /**
     * Update the score display
     * @param {number} score - Current score
     */
    static renderScore(score) {
        document.getElementById('score').textContent = score;
    }

    /**
     * Update the word history display
     * @param {Array} wordHistory - Array of {word, score} objects
     */
    static renderWordHistory(wordHistory) {
        const historyEl = document.getElementById('lastWords');
        historyEl.innerHTML = '';
        for (let item of wordHistory) {
            const wordEl = document.createElement('div');
            wordEl.className = 'word-item';
            wordEl.textContent = `${item.word} +${item.score}`;
            historyEl.appendChild(wordEl);
        }
    }

    /**
     * Show a temporary message to the user
     * @param {string} text - Message text
     * @param {string} type - Message type: 'success', 'error', or 'info'
     */
    static showMessage(text, type) {
        const messageEl = document.getElementById('message');
        messageEl.textContent = text;
        messageEl.className = `message ${type}`;
        setTimeout(() => {
            messageEl.textContent = '';
            messageEl.className = 'message';
        }, 3000);
    }

    /**
     * Show the game over modal
     * @param {number} finalScore - The final score
     */
    static showGameOver(finalScore) {
        document.getElementById('finalScore').textContent = finalScore;
        document.getElementById('gameOverModal').classList.add('show');
        document.getElementById('overlay').classList.add('show');
    }
}
