<script lang="ts">
  import { goto } from '$app/navigation';

  let userCode = `function add(a, b) {
  // Your code here
}`;

  let isSubmitted = false;
  let isCorrect = false;
  let feedback = '';

  const testCases = [
    { input: [2, 3], expected: 5 },
    { input: [0, 0], expected: 0 },
    { input: [-1, 1], expected: 0 },
    { input: [10, 20], expected: 30 }
  ];

  function runCode() {
    try {
      // Create a safe evaluation environment
      const func = new Function('a', 'b', userCode.replace('function add(a, b) {', '').replace(/}$/, ''));
      
      let allPassed = true;
      let results = [];

      for (const testCase of testCases) {
        const result = func(testCase.input[0], testCase.input[1]);
        const passed = result === testCase.expected;
        allPassed = allPassed && passed;
        
        results.push({
          input: testCase.input,
          expected: testCase.expected,
          actual: result,
          passed
        });
      }

      isSubmitted = true;
      isCorrect = allPassed;
      
      if (allPassed) {
        feedback = '🎉 All test cases passed! Your function works correctly.';
      } else {
        feedback = '❌ Some test cases failed. Check your implementation.';
      }
    } catch (error) {
      isSubmitted = true;
      isCorrect = false;
      feedback = `❌ Error: ${error instanceof Error ? error.message : 'Unknown error'}`;
    }
  }

  function resetCode() {
    userCode = `function add(a, b) {
  // Your code here
}`;
    isSubmitted = false;
    isCorrect = false;
    feedback = '';
  }
</script>

<svelte:head>
  <title>Code Component 1</title>
</svelte:head>

<div class="component-page">
  <div class="header">
    <button class="back-button" on:click={() => goto('/demos/learning-path')}>
      ← Back to Roadmap
    </button>
    <h1>Code Component 1</h1>
  </div>

  <div class="content">
    <div class="code-container">
      <div class="instructions">
        <h2>Write a Function to Add Two Numbers</h2>
        <p>Complete the function below to add two numbers together. The function should return the sum of the two parameters.</p>
        
        <div class="example">
          <h3>Example:</h3>
          <pre><code>add(2, 3) → 5
add(0, 0) → 0
add(-1, 1) → 0</code></pre>
        </div>

        <div class="test-cases">
          <h3>Test Cases:</h3>
          <ul>
            {#each testCases as testCase}
              <li><code>add({testCase.input[0]}, {testCase.input[1]})</code> should return <code>{testCase.expected}</code></li>
            {/each}
          </ul>
        </div>
      </div>

      <div class="editor-section">
        <h3>Your Code:</h3>
        <textarea
          bind:value={userCode}
          class="code-editor"
          placeholder="Write your function here..."
          disabled={isSubmitted}
        ></textarea>

        <div class="button-group">
          {#if !isSubmitted}
            <button class="run-button" on:click={runCode}>
              Run Code
            </button>
          {:else}
            <button class="reset-button" on:click={resetCode}>
              Try Again
            </button>
            <button class="complete-button" on:click={() => goto('/demos/learning-path')}>
              Continue
            </button>
          {/if}
        </div>
      </div>

      {#if isSubmitted}
        <div class="feedback-section">
          <div class="feedback {isCorrect ? 'correct' : 'incorrect'}">
            <h3>{isCorrect ? '🎉 Success!' : '❌ Try Again'}</h3>
            <p>{feedback}</p>
          </div>

          {#if !isCorrect}
            <div class="hint">
              <h4>💡 Hint:</h4>
              <p>Make sure your function returns the sum of the two parameters. You can use the <code>+</code> operator to add numbers in JavaScript.</p>
            </div>
          {/if}
        </div>
      {/if}
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
    max-width: 1000px;
    margin: 0 auto;
  }

  .code-container {
    background: #2a2a2a;
    border-radius: 12px;
    padding: 40px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.3);
  }

  .instructions h2 {
    color: #b78af0;
    margin-bottom: 20px;
    font-size: 1.8rem;
  }

  .instructions p {
    font-size: 1.1rem;
    line-height: 1.6;
    margin-bottom: 30px;
    color: #fff;
  }

  .example {
    background: #333;
    padding: 20px;
    border-radius: 8px;
    margin-bottom: 30px;
  }

  .example h3 {
    color: #46cb2f;
    margin-bottom: 16px;
    font-size: 1.2rem;
  }

  .example pre {
    background: #1a1a1a;
    padding: 16px;
    border-radius: 6px;
    overflow-x: auto;
    margin: 0;
  }

  .example code {
    color: #b78af0;
    font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
  }

  .test-cases {
    margin-bottom: 30px;
  }

  .test-cases h3 {
    color: #46cb2f;
    margin-bottom: 16px;
    font-size: 1.2rem;
  }

  .test-cases ul {
    list-style: none;
    padding: 0;
  }

  .test-cases li {
    padding: 8px 0;
    font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
    font-size: 0.9rem;
  }

  .test-cases code {
    color: #b78af0;
    background: #333;
    padding: 2px 6px;
    border-radius: 4px;
  }

  .editor-section {
    margin-bottom: 30px;
  }

  .editor-section h3 {
    color: #46cb2f;
    margin-bottom: 16px;
    font-size: 1.2rem;
  }

  .code-editor {
    width: 100%;
    min-height: 200px;
    background: #1a1a1a;
    border: 2px solid #555;
    border-radius: 8px;
    color: #fff;
    font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
    font-size: 14px;
    line-height: 1.5;
    padding: 20px;
    resize: vertical;
    transition: border-color 0.2s;
  }

  .code-editor:focus {
    outline: none;
    border-color: #b78af0;
  }

  .code-editor:disabled {
    opacity: 0.7;
    cursor: not-allowed;
  }

  .button-group {
    display: flex;
    gap: 16px;
    margin-top: 20px;
  }

  .run-button, .reset-button, .complete-button {
    padding: 12px 24px;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 1rem;
    font-weight: 600;
    transition: all 0.2s;
  }

  .run-button {
    background: #b78af0;
    color: #fff;
  }

  .run-button:hover {
    background: #a67ae0;
    transform: translateY(-2px);
  }

  .reset-button {
    background: #666;
    color: #fff;
  }

  .reset-button:hover {
    background: #777;
    transform: translateY(-2px);
  }

  .complete-button {
    background: #46cb2f;
    color: #fff;
  }

  .complete-button:hover {
    background: #3ba026;
    transform: translateY(-2px);
  }

  .feedback-section {
    margin-top: 30px;
  }

  .feedback {
    padding: 20px;
    border-radius: 8px;
    margin-bottom: 20px;
  }

  .feedback.correct {
    background: rgba(70, 203, 47, 0.1);
    border: 1px solid #46cb2f;
  }

  .feedback.incorrect {
    background: rgba(255, 107, 107, 0.1);
    border: 1px solid #ff6b6b;
  }

  .feedback h3 {
    margin-bottom: 10px;
    font-size: 1.3rem;
  }

  .hint {
    background: rgba(183, 138, 240, 0.1);
    border: 1px solid #b78af0;
    padding: 20px;
    border-radius: 8px;
  }

  .hint h4 {
    color: #b78af0;
    margin-bottom: 10px;
    font-size: 1.1rem;
  }

  .hint code {
    background: #333;
    padding: 2px 6px;
    border-radius: 4px;
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

    .code-container {
      padding: 20px;
    }

    .button-group {
      flex-direction: column;
    }
  }
</style> 