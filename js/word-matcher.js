/**
 * Word matching and scoring module
 * Handles word finding, validation, and score calculation
 */

class WordMatcher {
    /**
     * Find a word on the board (horizontal or vertical)
     * @param {Array} board - The game board
     * @param {string} word - The word to find
     * @returns {Array} Array of {row, col} positions if found, empty array otherwise
     */
    static findWordInBoard(board, word) {
        // Try to find the word reading left-to-right and top-to-bottom
        for (let row = 0; row < BOARD_HEIGHT; row++) {
            for (let col = 0; col < BOARD_WIDTH; col++) {
                if (board[row][col] && board[row][col].letter === word[0]) {
                    // Try horizontal
                    let horizontalMatches = this.tryMatchHorizontal(board, word, row, col);
                    if (horizontalMatches.length === word.length) {
                        return horizontalMatches;
                    }

                    // Try vertical
                    let verticalMatches = this.tryMatchVertical(board, word, row, col);
                    if (verticalMatches.length === word.length) {
                        return verticalMatches;
                    }
                }
            }
        }
        return [];
    }

    /**
     * Try to match a word horizontally starting at position
     * @param {Array} board - The game board
     * @param {string} word - The word to match
     * @param {number} row - Starting row
     * @param {number} startCol - Starting column
     * @returns {Array} Array of matching positions or empty array
     */
    static tryMatchHorizontal(board, word, row, startCol) {
        const matches = [];
        for (let i = 0; i < word.length; i++) {
            const col = startCol + i;
            if (col >= BOARD_WIDTH || !board[row][col] || board[row][col].letter !== word[i]) {
                return [];
            }
            matches.push({ row, col });
        }
        return matches;
    }

    /**
     * Try to match a word vertically starting at position
     * @param {Array} board - The game board
     * @param {string} word - The word to match
     * @param {number} startRow - Starting row
     * @param {number} col - Column
     * @returns {Array} Array of matching positions or empty array
     */
    static tryMatchVertical(board, word, startRow, col) {
        const matches = [];
        for (let i = 0; i < word.length; i++) {
            const row = startRow + i;
            if (row >= BOARD_HEIGHT || !board[row][col] || board[row][col].letter !== word[i]) {
                return [];
            }
            matches.push({ row, col });
        }
        return matches;
    }

    /**
     * Calculate score for a word based on Scrabble rules and bonuses
     * @param {Array} board - The game board
     * @param {Array} matches - Array of {row, col} positions
     * @param {string} word - The word (for length bonus)
     * @returns {number} Total score
     */
    static calculateScore(board, matches, word) {
        let wordScore = 0;
        let wordMultiplier = 1;
        let hasDoubleWord = false;
        let hasTripleWord = false;

        // Calculate letter scores
        for (let pos of matches) {
            const cell = board[pos.row][pos.col];
            const letterValue = LETTER_VALUES[cell.letter] || 0;
            let letterScore = letterValue;

            if (cell.bonus === 'double-letter') {
                letterScore *= 2;
            } else if (cell.bonus === 'triple-letter') {
                letterScore *= 3;
            } else if (cell.bonus === 'double-word') {
                hasDoubleWord = true;
            } else if (cell.bonus === 'triple-word') {
                hasTripleWord = true;
            }

            wordScore += letterScore;
        }

        // Apply word multipliers
        if (hasTripleWord) {
            wordMultiplier = 3;
        } else if (hasDoubleWord) {
            wordMultiplier = 2;
        }

        // Double points for 7+ letter words
        if (word.length >= 7) {
            wordMultiplier *= 2;
        }

        return wordScore * wordMultiplier;
    }
}
