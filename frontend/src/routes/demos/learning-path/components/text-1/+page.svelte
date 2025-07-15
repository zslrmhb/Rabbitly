<script lang="ts">
  import { goto } from '$app/navigation';
</script>

<svelte:head>
  <title>Text Component 1</title>
</svelte:head>

<div class="component-page">
  <div class="header">
    <button class="back-button" on:click={() => goto('/demos/learning-path')}>
      ← Back to Roadmap
    </button>
    <h1>Text Component 1</h1>
  </div>

  <div class="content">
    <h2>Introduction to Text Components</h2>
    <p>Welcome to your first text component! This is where you'll learn the fundamentals of text-based learning.</p>
    
    <div class="text-section">
      <h3>What you'll learn:</h3>
      <ul>
        <li>How to read and understand text content</li>
        <li>Key concepts and terminology</li>
        <li>Important definitions and explanations</li>
        <li>Real-world examples and applications</li>
      </ul>
    </div>

    <div class="text-section">
      <h3>Key Concepts</h3>
      <p>Text components are the foundation of any learning experience. They provide:</p>
      <ul>
        <li><strong>Clear explanations</strong> of complex topics</li>
        <li><strong>Step-by-step guidance</strong> through processes</li>
        <li><strong>Context and background</strong> for practical exercises</li>
        <li><strong>Reference material</strong> for future review</li>
      </ul>
    </div>

    <div class="text-section">
      <h3>Best Practices</h3>
      <p>When working with text components:</p>
      <ol>
        <li>Read through the content carefully</li>
        <li>Take notes on important points</li>
        <li>Ask questions if something isn't clear</li>
        <li>Review the material before moving on</li>
      </ol>
    </div>

    <div class="completion-section">
      <h3>Ready to continue?</h3>
      <p>Once you've read through this content, you can move on to the next component.</p>
      <button class="complete-button" on:click={() => goto('/demos/learning-path')}>
        Mark as Complete
      </button>
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

  .text-section {
    margin-bottom: 40px;
    padding: 30px;
    background: #2a2a2a;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.3);
  }

  .text-section h2 {
    color: #b78af0;
    margin-bottom: 20px;
    font-size: 1.8rem;
  }

  .text-section h3 {
    color: #46cb2f;
    margin-bottom: 16px;
    font-size: 1.3rem;
  }

  .text-section p {
    line-height: 1.6;
    margin-bottom: 16px;
    font-size: 1.1rem;
  }

  .text-section ul, .text-section ol {
    margin: 16px 0;
    padding-left: 20px;
  }

  .text-section li {
    margin-bottom: 8px;
    line-height: 1.5;
  }

  .completion-section {
    text-align: center;
    margin-top: 60px;
    padding: 40px;
    background: linear-gradient(135deg, #2d5a2d 0%, #1a3d1a 100%);
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.3);
  }

  .completion-section h3 {
    color: #46cb2f;
    margin-bottom: 16px;
    font-size: 1.5rem;
  }

  .complete-button {
    padding: 16px 32px;
    background: #46cb2f;
    border: none;
    color: #fff;
    border-radius: 8px;
    cursor: pointer;
    font-size: 1.1rem;
    font-weight: 600;
    transition: all 0.2s;
    margin-top: 20px;
  }

  .complete-button:hover {
    background: #3ba026;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(70, 203, 47, 0.3);
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

    .text-section {
      padding: 20px;
    }
  }
</style> 