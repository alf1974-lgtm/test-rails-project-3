/**
 * Piece management module
 * Handles tetromino creation, manipulation, and letter assignment
 */

class PieceManager {
    /**
     * Get a random tetromino piece
     * @returns {Object} A piece object with shape, color, and letters
     */
    static getRandomPiece() {
        const piece = JSON.parse(JSON.stringify(PIECES[Math.floor(Math.random() * PIECES.length)]));
        return piece;
    }

    /**
     * Add random letters and bonus tiles to a piece
     * @param {Object} piece - The piece to add letters to
     */
    static addLettersToPiece(piece) {
        piece.letters = [];
        for (let row of piece.shape) {
            let letterRow = [];
            for (let cell of row) {
                if (cell === 1) {
                    const letter = String.fromCharCode(65 + Math.floor(Math.random() * 26));
                    const bonus = Math.random() < BONUS_CHANCE ? this.getRandomBonus() : null;
                    letterRow.push({ letter, bonus });
                } else {
                    letterRow.push(null);
                }
            }
            piece.letters.push(letterRow);
        }
    }

    /**
     * Get a random bonus tile type
     * @returns {string} One of: 'double-word', 'triple-word', 'double-letter', 'triple-letter'
     */
    static getRandomBonus() {
        const bonuses = ['double-word', 'triple-word', 'double-letter', 'triple-letter'];
        return bonuses[Math.floor(Math.random() * bonuses.length)];
    }

    /**
     * Rotate a matrix 90 degrees clockwise
     * @param {Array} matrix - 2D array to rotate
     * @returns {Array} Rotated matrix
     */
    static rotateCW(matrix) {
        const n = matrix.length;
        const m = matrix[0].length;
        const rotated = Array(m).fill(null).map(() => Array(n).fill(null));
        for (let i = 0; i < n; i++) {
            for (let j = 0; j < m; j++) {
                rotated[j][n - 1 - i] = matrix[i][j];
            }
        }
        return rotated;
    }
}
