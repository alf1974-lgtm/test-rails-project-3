/**
 * Board collision and physics module
 * Handles collision detection, gravity, and line clearing
 */

class BoardPhysics {
    /**
     * Check if a piece collides with board boundaries or existing blocks
     * @param {Array} board - The game board
     * @param {number} x - X position of piece
     * @param {number} y - Y position of piece
     * @param {Array} shape - The piece shape
     * @returns {boolean} True if collision detected
     */
    static collides(board, x, y, shape) {
        for (let row = 0; row < shape.length; row++) {
            for (let col = 0; col < shape[row].length; col++) {
                if (shape[row][col] === 1) {
                    const boardX = x + col;
                    const boardY = y + row;
                    if (boardX < 0 || boardX >= BOARD_WIDTH || boardY >= BOARD_HEIGHT) {
                        return true;
                    }
                    if (boardY >= 0 && board[boardY][boardX] !== null) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    /**
     * Lock a piece onto the board
     * @param {Array} board - The game board
     * @param {Object} piece - The piece to lock
     * @param {number} x - X position
     * @param {number} y - Y position
     */
    static lockPiece(board, piece, x, y) {
        for (let row = 0; row < piece.shape.length; row++) {
            for (let col = 0; col < piece.shape[row].length; col++) {
                if (piece.shape[row][col] === 1) {
                    const boardX = x + col;
                    const boardY = y + row;
                    if (boardY >= 0) {
                        board[boardY][boardX] = {
                            letter: piece.letters[row][col].letter,
                            bonus: piece.letters[row][col].bonus,
                            color: piece.color
                        };
                    }
                }
            }
        }
    }

    /**
     * Clear completed lines and return number of lines cleared
     * @param {Array} board - The game board
     * @returns {number} Number of lines cleared
     */
    static clearLines(board) {
        let linesCleared = 0;
        for (let row = BOARD_HEIGHT - 1; row >= 0; row--) {
            if (board[row].every(cell => cell !== null)) {
                board.splice(row, 1);
                board.unshift(Array(BOARD_WIDTH).fill(null));
                linesCleared++;
                row++;
            }
        }
        return linesCleared;
    }

    /**
     * Apply gravity - make blocks fall down
     * @param {Array} board - The game board
     */
    static applyGravity(board) {
        for (let col = 0; col < BOARD_WIDTH; col++) {
            let writePos = BOARD_HEIGHT - 1;
            for (let row = BOARD_HEIGHT - 1; row >= 0; row--) {
                if (board[row][col] !== null) {
                    board[writePos][col] = board[row][col];
                    if (writePos !== row) {
                        board[row][col] = null;
                    }
                    writePos--;
                }
            }
        }
    }
}
