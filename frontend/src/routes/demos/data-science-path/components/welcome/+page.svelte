<script lang="ts">
  import { goto } from '$app/navigation';
</script>

<svelte:head>
  <title>Welcome to Data Science</title>
</svelte:head>

<div class="component-page">
  <div class="header">
    <button class="back-button" on:click={() => goto('/demos/data-science-path')}>
      ← Back to Roadmap
    </button>
    <h1>Welcome to Data Science</h1>
  </div>

  <div class="content">
    <div class="welcome-section">
      <h2>🚀 Welcome to the Exciting World of Data Science!</h2>
      <p>Data Science is the art and science of extracting meaningful insights from data. It combines statistics, programming, and domain expertise to solve real-world problems.</p>
      
      <div class="highlight-box">
        <h3>What is Data Science?</h3>
        <p>Data Science is an interdisciplinary field that uses scientific methods, processes, algorithms, and systems to extract knowledge and insights from structured and unstructured data. It's like being a detective, but instead of solving crimes, you're solving business problems, scientific questions, and societal challenges using data as your evidence.</p>
      </div>

      <div class="content-section">
        <h3>🎯 What You'll Learn in This Course</h3>
        <div class="learning-objectives">
          <div class="objective">
            <span class="objective-icon">📊</span>
            <div>
              <h4>Data Fundamentals</h4>
              <p>Understanding different data types, collection methods, and basic statistical concepts</p>
            </div>
          </div>
          
          <div class="objective">
            <span class="objective-icon">🔍</span>
            <div>
              <h4>Data Exploration</h4>
              <p>Learning to explore and understand datasets through visualization and analysis</p>
            </div>
          </div>
          
          <div class="objective">
            <span class="objective-icon">🧹</span>
            <div>
              <h4>Data Cleaning</h4>
              <p>Mastering techniques to clean, preprocess, and prepare data for analysis</p>
            </div>
          </div>
          
          <div class="objective">
            <span class="objective-icon">📈</span>
            <div>
              <h4>Data Visualization</h4>
              <p>Creating meaningful charts and graphs to communicate insights effectively</p>
            </div>
          </div>
          
          <div class="objective">
            <span class="objective-icon">🤖</span>
            <div>
              <h4>Machine Learning Basics</h4>
              <p>Introduction to predictive modeling and machine learning concepts</p>
            </div>
          </div>
        </div>
      </div>

      <div class="content-section">
        <h3>💡 Why Data Science Matters</h3>
        <p>In today's data-driven world, organizations of all sizes are collecting massive amounts of data. However, raw data is like a puzzle with missing pieces - it needs to be processed, analyzed, and interpreted to reveal valuable insights.</p>
        
        <div class="applications">
          <h4>Real-World Applications:</h4>
          <ul>
            <li><strong>Business Intelligence:</strong> Helping companies make data-driven decisions</li>
            <li><strong>Healthcare:</strong> Improving patient outcomes through predictive analytics</li>
            <li><strong>Finance:</strong> Detecting fraud and managing risk</li>
            <li><strong>Marketing:</strong> Understanding customer behavior and preferences</li>
            <li><strong>Scientific Research:</strong> Accelerating discoveries in various fields</li>
          </ul>
        </div>
      </div>

      <div class="content-section">
        <h3>🎓 Course Structure</h3>
        <p>This course is designed to be hands-on and practical. You'll work with real datasets, build interactive visualizations, and develop the skills needed to make data-driven decisions.</p>
        
        <div class="course-progression">
          <div class="progression-step">
            <div class="step-number">1</div>
            <div class="step-content">
              <h4>Getting Started</h4>
              <p>Welcome to data science, introduction quiz, and environment setup</p>
            </div>
          </div>
          
          <div class="progression-step">
            <div class="step-number">2</div>
            <div class="step-content">
              <h4>Data Fundamentals</h4>
              <p>Data types, collection methods, exploration, and cleaning techniques</p>
            </div>
          </div>
        </div>
      </div>

      <div class="completion-section">
        <h3>Ready to Begin Your Data Science Journey?</h3>
        <p>Click the button below to mark this section as complete and continue to the next lesson.</p>
        <button class="complete-button" on:click={() => goto('/demos/data-science-path')}>
          Mark as Complete
        </button>
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

  .welcome-section {
    background: #2a2a2a;
    border-radius: 12px;
    padding: 40px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.3);
  }

  .welcome-section h2 {
    color: #b78af0;
    margin-bottom: 20px;
    font-size: 1.8rem;
  }

  .welcome-section p {
    font-size: 1.1rem;
    line-height: 1.6;
    margin-bottom: 30px;
    color: #fff;
  }

  .highlight-box {
    background: linear-gradient(135deg, rgba(183, 138, 240, 0.1) 0%, rgba(70, 203, 47, 0.1) 100%);
    border: 1px solid #b78af0;
    padding: 30px;
    border-radius: 12px;
    margin-bottom: 40px;
  }

  .highlight-box h3 {
    color: #b78af0;
    margin-bottom: 16px;
    font-size: 1.3rem;
  }

  .content-section {
    margin-bottom: 40px;
  }

  .content-section h3 {
    color: #46cb2f;
    margin-bottom: 20px;
    font-size: 1.4rem;
  }

  .learning-objectives {
    display: flex;
    flex-direction: column;
    gap: 20px;
  }

  .objective {
    display: flex;
    align-items: flex-start;
    gap: 16px;
    padding: 20px;
    background: #333;
    border-radius: 8px;
    border-left: 4px solid #b78af0;
  }

  .objective-icon {
    font-size: 2rem;
    flex-shrink: 0;
  }

  .objective h4 {
    color: #b78af0;
    margin-bottom: 8px;
    font-size: 1.1rem;
  }

  .objective p {
    color: rgba(255,255,255,0.8);
    font-size: 0.95rem;
    line-height: 1.5;
    margin: 0;
  }

  .applications h4 {
    color: #46cb2f;
    margin-bottom: 16px;
    font-size: 1.1rem;
  }

  .applications ul {
    list-style: none;
    padding: 0;
  }

  .applications li {
    padding: 8px 0;
    border-bottom: 1px solid #444;
    font-size: 0.95rem;
    line-height: 1.5;
  }

  .applications li:last-child {
    border-bottom: none;
  }

  .applications strong {
    color: #b78af0;
  }

  .course-progression {
    display: flex;
    flex-direction: column;
    gap: 20px;
  }

  .progression-step {
    display: flex;
    align-items: flex-start;
    gap: 16px;
    padding: 20px;
    background: #333;
    border-radius: 8px;
  }

  .step-number {
    width: 40px;
    height: 40px;
    background: #b78af0;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    font-size: 1.2rem;
    flex-shrink: 0;
  }

  .step-content h4 {
    color: #b78af0;
    margin-bottom: 8px;
    font-size: 1.1rem;
  }

  .step-content p {
    color: rgba(255,255,255,0.8);
    font-size: 0.95rem;
    line-height: 1.5;
    margin: 0;
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

    .welcome-section {
      padding: 20px;
    }

    .objective {
      flex-direction: column;
      text-align: center;
    }

    .progression-step {
      flex-direction: column;
      text-align: center;
    }
  }
</style> 