/**
 * Main Game class
 * Orchestrates all game logic, state management, and rendering
 */

class Game {
    constructor() {
        // Initialize game state
        this.board = Array(BOARD_HEIGHT).fill(null).map(() => Array(BOARD_WIDTH).fill(null));
        this.score = 0;
        this.gameOver = false;
        this.currentPiece = null;
        this.nextPiece = null;
        this.currentX = 0;
        this.currentY = 0;
        this.wordHistory = [];
        this.dictionary = new Dictionary();
        this.gameSpeed = GAME_SPEED;
        this.lastDropTime = Date.now();

        // Initialize game
        this.spawnPiece();
        this.render();
        InputHandler.setupEventListeners(this);
        this.gameLoop();
    }

    /**
     * Spawn a new piece at the top of the board
     */
    spawnPiece() {
        if (this.nextPiece === null) {
            this.nextPiece = PieceManager.getRandomPiece();
        }
        this.currentPiece = this.nextPiece;
        this.nextPiece = PieceManager.getRandomPiece();
        this.currentX = Math.floor(BOARD_WIDTH / 2) - 1;
        this.currentY = 0;

        // Add letters to the piece
        PieceManager.addLettersToPiece(this.currentPiece);
        PieceManager.addLettersToPiece(this.nextPiece);

        // Check if game is over (piece can't spawn)
        if (BoardPhysics.collides(this.board, this.currentX, this.currentY, this.currentPiece.shape)) {
            this.endGame();
        }
    }

    /**
     * Move the current piece left or right
     * @param {number} dx - Change in X (-1 for left, 1 for right)
     * @param {number} dy - Change in Y (usually 0)
     */
    movePiece(dx, dy) {
        if (!BoardPhysics.collides(this.board, this.currentX + dx, this.currentY + dy, this.currentPiece.shape)) {
            this.currentX += dx;
            this.currentY += dy;
            this.render();
        }
    }

    /**
     * Rotate the current piece 90 degrees clockwise
     */
    rotatePiece() {
        const rotated = PieceManager.rotateCW(this.currentPiece.shape);
        const rotatedLetters = PieceManager.rotateCW(this.currentPiece.letters);
        if (!BoardPhysics.collides(this.board, this.currentX, this.currentY, rotated)) {
            this.currentPiece.shape = rotated;
            this.currentPiece.letters = rotatedLetters;
            this.render();
        }
    }

    /**
     * Drop the current piece all the way down
     */
    dropPiece() {
        while (!BoardPhysics.collides(this.board, this.currentX, this.currentY + 1, this.currentPiece.shape)) {
            this.currentY++;
        }
        this.lockPiece();
    }

    /**
     * Lock the current piece onto the board
     */
    lockPiece() {
        BoardPhysics.lockPiece(this.board, this.currentPiece, this.currentX, this.currentY);
        
        // Clear completed lines and add points
        const linesCleared = BoardPhysics.clearLines(this.board);
        if (linesCleared > 0) {
            this.score += linesCleared * POINTS_PER_LINE;
        }

        this.spawnPiece();
        this.render();
    }

    /**
     * Submit a word and check if it's on the board
     */
    submitWord() {
        const input = document.getElementById('wordInput');
        const word = input.value.toUpperCase().trim();
        input.value = '';

        if (!word) {
            UIRenderer.showMessage('Please enter a word', 'error');
            return;
        }

        if (!this.dictionary.isValid(word)) {
            UIRenderer.showMessage(`"${word}" is not a valid word`, 'error');
            return;
        }

        const matches = WordMatcher.findWordInBoard(this.board, word);
        if (matches.length === 0) {
            UIRenderer.showMessage(`"${word}" not found on board`, 'error');
            return;
        }

        // Calculate score
        const wordScore = WordMatcher.calculateScore(this.board, matches, word);

        // Remove matched blocks
        for (let pos of matches) {
            this.board[pos.row][pos.col] = null;
        }

        // Apply gravity
        BoardPhysics.applyGravity(this.board);

        // Update game state
        this.score += wordScore;
        this.wordHistory.unshift({ word, score: wordScore });
        if (this.wordHistory.length > WORD_HISTORY_MAX) {
            this.wordHistory.pop();
        }

        UIRenderer.showMessage(`"${word}" +${wordScore} points!`, 'success');
        this.render();
    }

    /**
     * Main game loop - handles automatic piece dropping
     */
    gameLoop() {
        if (!this.gameOver) {
            const now = Date.now();
            if (now - this.lastDropTime > this.gameSpeed) {
                if (!BoardPhysics.collides(this.board, this.currentX, this.currentY + 1, this.currentPiece.shape)) {
                    this.currentY++;
                } else {
                    this.lockPiece();
                }
                this.lastDropTime = now;
                this.render();
            }
            requestAnimationFrame(() => this.gameLoop());
        }
    }

    /**
     * End the game and show game over screen
     */
    endGame() {
        this.gameOver = true;
        UIRenderer.showGameOver(this.score);
    }

    /**
     * Render all game elements
     */
    render() {
        UIRenderer.renderBoard(this.board, this.currentPiece, this.currentX, this.currentY);
        UIRenderer.renderNextPiece(this.nextPiece);
        UIRenderer.renderScore(this.score);
        UIRenderer.renderWordHistory(this.wordHistory);
    }
}
