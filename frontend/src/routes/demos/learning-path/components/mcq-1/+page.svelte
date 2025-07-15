<script lang="ts">
  import { goto } from '$app/navigation';

  let selectedAnswer = '';
  let isSubmitted = false;
  let isCorrect = false;

  const questions = [
    {
      question: "What is the primary purpose of text components in learning?",
      options: [
        "To provide entertainment",
        "To give clear explanations of complex topics",
        "To replace all other learning methods",
        "To make learning more difficult"
      ],
      correctAnswer: 1
    },
    {
      question: "Which of the following is NOT a best practice when working with text components?",
      options: [
        "Reading through content carefully",
        "Taking notes on important points",
        "Skipping sections you don't understand",
        "Reviewing material before moving on"
      ],
      correctAnswer: 2
    }
  ];

  let currentQuestionIndex = 0;
  let score = 0;

  function selectAnswer(index: number) {
    if (!isSubmitted) {
      selectedAnswer = index.toString();
    }
  }

  function submitAnswer() {
    if (selectedAnswer === '') return;
    
    isSubmitted = true;
    isCorrect = parseInt(selectedAnswer) === questions[currentQuestionIndex].correctAnswer;
    
    if (isCorrect) {
      score++;
    }
  }

  function nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
      selectedAnswer = '';
      isSubmitted = false;
      isCorrect = false;
    } else {
      // Quiz completed
      goto('/demos/learning-path');
    }
  }
</script>

<svelte:head>
  <title>Multiple Choice 1</title>
</svelte:head>

<div class="component-page">
  <div class="header">
    <button class="back-button" on:click={() => goto('/demos/learning-path')}>
      ← Back to Roadmap
    </button>
    <h1>Multiple Choice 1</h1>
  </div>

  <div class="content">
    <div class="quiz-container">
      <div class="progress-bar">
        <div class="progress" style="width: {((currentQuestionIndex + 1) / questions.length) * 100}%"></div>
      </div>

      <div class="question-section">
        <h2>Question {currentQuestionIndex + 1} of {questions.length}</h2>
        <p class="question-text">{questions[currentQuestionIndex].question}</p>

        <div class="options">
          {#each questions[currentQuestionIndex].options as option, index}
            <button
              class="option {selectedAnswer === index.toString() ? 'selected' : ''} {isSubmitted ? (index === questions[currentQuestionIndex].correctAnswer ? 'correct' : (selectedAnswer === index.toString() && !isCorrect ? 'incorrect' : '')) : ''}"
              on:click={() => selectAnswer(index)}
              disabled={isSubmitted}
            >
              <span class="option-letter">{String.fromCharCode(65 + index)}</span>
              <span class="option-text">{option}</span>
              {#if isSubmitted && index === questions[currentQuestionIndex].correctAnswer}
                <span class="checkmark">✔</span>
              {/if}
              {#if isSubmitted && selectedAnswer === index.toString() && !isCorrect}
                <span class="cross">✗</span>
              {/if}
            </button>
          {/each}
        </div>

        {#if !isSubmitted}
          <button 
            class="submit-button" 
            on:click={submitAnswer}
            disabled={selectedAnswer === ''}
          >
            Submit Answer
          </button>
        {:else}
          <div class="feedback">
            {#if isCorrect}
              <div class="correct-feedback">
                <h3>🎉 Correct!</h3>
                <p>Great job! You've understood the concept well.</p>
              </div>
            {:else}
              <div class="incorrect-feedback">
                <h3>❌ Incorrect</h3>
                <p>The correct answer was: <strong>{questions[currentQuestionIndex].options[questions[currentQuestionIndex].correctAnswer]}</strong></p>
              </div>
            {/if}
            
            <button class="next-button" on:click={nextQuestion}>
              {currentQuestionIndex < questions.length - 1 ? 'Next Question' : 'Complete Quiz'}
            </button>
          </div>
        {/if}
      </div>

      <div class="score-display">
        Score: {score}/{questions.length}
      </div>
    </div>
  </div>
</div>

<style>
  .component-page {
    min-height: 100vh;
    background: #1a1a1a;
    color: #fff;
    padding: 40px 20px;
  }

  .header {
    display: flex;
    align-items: center;
    gap: 20px;
    margin-bottom: 40px;
    padding-bottom: 20px;
    border-bottom: 1px solid #333;
  }

  .back-button {
    padding: 10px 16px;
    background: #333;
    border: 1px solid #555;
    color: #fff;
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.2s;
    font-size: 0.9rem;
  }

  .back-button:hover {
    background: #444;
    transform: translateX(-2px);
  }

  .header h1 {
    margin: 0;
    color: #b78af0;
    font-size: 2rem;
  }

  .content {
    max-width: 800px;
    margin: 0 auto;
  }

  .quiz-container {
    background: #2a2a2a;
    border-radius: 12px;
    padding: 40px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.3);
  }

  .progress-bar {
    width: 100%;
    height: 8px;
    background: #333;
    border-radius: 4px;
    margin-bottom: 30px;
    overflow: hidden;
  }

  .progress {
    height: 100%;
    background: linear-gradient(90deg, #b78af0, #46cb2f);
    transition: width 0.3s ease;
  }

  .question-section h2 {
    color: #b78af0;
    margin-bottom: 20px;
    font-size: 1.5rem;
  }

  .question-text {
    font-size: 1.2rem;
    line-height: 1.6;
    margin-bottom: 30px;
    color: #fff;
  }

  .options {
    display: flex;
    flex-direction: column;
    gap: 12px;
    margin-bottom: 30px;
  }

  .option {
    display: flex;
    align-items: center;
    gap: 16px;
    padding: 16px 20px;
    background: #333;
    border: 2px solid #555;
    border-radius: 8px;
    color: #fff;
    cursor: pointer;
    transition: all 0.2s;
    text-align: left;
    width: 100%;
  }

  .option:hover:not(:disabled) {
    background: #444;
    border-color: #b78af0;
  }

  .option.selected {
    border-color: #b78af0;
    background: rgba(183, 138, 240, 0.1);
  }

  .option.correct {
    border-color: #46cb2f;
    background: rgba(70, 203, 47, 0.1);
  }

  .option.incorrect {
    border-color: #ff6b6b;
    background: rgba(255, 107, 107, 0.1);
  }

  .option-letter {
    width: 32px;
    height: 32px;
    background: #555;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    font-size: 0.9rem;
  }

  .option.selected .option-letter {
    background: #b78af0;
  }

  .option.correct .option-letter {
    background: #46cb2f;
  }

  .option.incorrect .option-letter {
    background: #ff6b6b;
  }

  .option-text {
    flex: 1;
    font-size: 1rem;
  }

  .checkmark {
    color: #46cb2f;
    font-weight: bold;
    font-size: 1.2rem;
  }

  .cross {
    color: #ff6b6b;
    font-weight: bold;
    font-size: 1.2rem;
  }

  .submit-button {
    padding: 16px 32px;
    background: #b78af0;
    border: none;
    color: #fff;
    border-radius: 8px;
    cursor: pointer;
    font-size: 1.1rem;
    font-weight: 600;
    transition: all 0.2s;
    width: 100%;
  }

  .submit-button:hover:not(:disabled) {
    background: #a67ae0;
    transform: translateY(-2px);
  }

  .submit-button:disabled {
    background: #555;
    cursor: not-allowed;
    transform: none;
  }

  .feedback {
    margin-top: 30px;
    padding: 20px;
    border-radius: 8px;
    text-align: center;
  }

  .correct-feedback {
    background: rgba(70, 203, 47, 0.1);
    border: 1px solid #46cb2f;
    margin-bottom: 20px;
  }

  .incorrect-feedback {
    background: rgba(255, 107, 107, 0.1);
    border: 1px solid #ff6b6b;
    margin-bottom: 20px;
  }

  .feedback h3 {
    margin-bottom: 10px;
    font-size: 1.3rem;
  }

  .next-button {
    padding: 16px 32px;
    background: #46cb2f;
    border: none;
    color: #fff;
    border-radius: 8px;
    cursor: pointer;
    font-size: 1.1rem;
    font-weight: 600;
    transition: all 0.2s;
  }

  .next-button:hover {
    background: #3ba026;
    transform: translateY(-2px);
  }

  .score-display {
    text-align: center;
    margin-top: 30px;
    padding: 16px;
    background: #333;
    border-radius: 8px;
    font-size: 1.1rem;
    font-weight: 600;
    color: #b78af0;
  }

  @media (max-width: 768px) {
    .component-page {
      padding: 20px 10px;
    }

    .header {
      flex-direction: column;
      align-items: flex-start;
      gap: 16px;
    }

    .header h1 {
      font-size: 1.5rem;
    }

    .quiz-container {
      padding: 20px;
    }

    .option {
      padding: 12px 16px;
    }

    .question-text {
      font-size: 1.1rem;
    }
  }
</style> 