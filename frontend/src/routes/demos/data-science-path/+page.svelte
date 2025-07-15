<script lang="ts">
  import LearningPath from '../../../components/course/LearningPath.svelte';
  import type { PathNode } from '$lib/types';
  import { goto } from '$app/navigation';

  let nodes: PathNode[] = [
    // Getting Started (Green nodes)
    { id: 'welcome', subTopicId: 'A', componentId: 'welcome', state: 'current' },
    { id: 'intro-quiz', subTopicId: 'A', componentId: 'intro-quiz', state: 'future' },
    { id: 'setup', subTopicId: 'A', componentId: 'setup', state: 'future' },
    
    // Data Fundamentals (Purple nodes)
    { id: 'data-types', subTopicId: 'B', componentId: 'data-types', state: 'locked' },
    { id: 'data-collection', subTopicId: 'B', componentId: 'data-collection', state: 'locked' },
    { id: 'fundamentals-quiz', subTopicId: 'B', componentId: 'fundamentals-quiz', state: 'locked' },
    { id: 'data-exploration', subTopicId: 'B', componentId: 'data-exploration', state: 'locked' },
    { id: 'data-cleaning', subTopicId: 'B', componentId: 'data-cleaning', state: 'locked' },
    
    // Milestone chest
    { id: 'chest', subTopicId: 'B', componentId: 'milestone', state: 'future', special: 'chest' },
    
    // End-of-course badge
    { id: 'badge', subTopicId: 'B', componentId: 'achievement', state: 'future', special: 'badge' }
  ];

  function handleNodeSelect(event: CustomEvent) {
    const nodeId = event.detail;
    const node = nodes.find(n => n.id === nodeId);
    
    if (node && node.state !== 'locked') {
      // Navigate to the component page
      goto(`/demos/data-science-path/components/${node.componentId}`);
    }
  }
</script>

<svelte:head>
  <title>Introduction to Data Science - Roadmap</title>
</svelte:head>

<div class="roadmap-container">
  <div class="roadmap-header">
    <h1>Introduction to Data Science</h1>
    <p>Master the fundamentals of data science through hands-on learning</p>
  </div>

  <div class="learning-path-container">
    <LearningPath
      {nodes}
      activeNodeId=""
      on:select={handleNodeSelect}
    />
  </div>

  <div class="roadmap-info">
    <h2>Course Overview</h2>
    <div class="course-description">
      <p>Welcome to the exciting world of Data Science! 🚀 This comprehensive course will guide you through the fundamental concepts, tools, and techniques that power modern data analysis.</p>
      
      <div class="course-highlights">
        <h3>What You'll Learn:</h3>
        <ul>
          <li><strong>Data Fundamentals:</strong> Understanding different data types and collection methods</li>
          <li><strong>Data Processing:</strong> Cleaning, exploring, and preparing data for analysis</li>
          <li><strong>Statistical Analysis:</strong> Basic statistical concepts and their applications</li>
          <li><strong>Data Visualization:</strong> Creating meaningful charts and graphs</li>
          <li><strong>Practical Projects:</strong> Hands-on experience with real datasets</li>
        </ul>
      </div>

      <div class="course-structure">
        <h3>Course Structure:</h3>
        <div class="structure-grid">
          <div class="structure-item">
            <h4>📚 Getting Started</h4>
            <p>Welcome to data science, introduction quiz, and environment setup</p>
          </div>
          <div class="structure-item">
            <h4>📊 Data Fundamentals</h4>
            <p>Data types, collection methods, exploration, and cleaning techniques</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<style>
  .roadmap-container {
    min-height: 100vh;
    background: #1a1a1a;
    color: #fff;
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 40px 20px;
  }

  .roadmap-header {
    text-align: center;
    margin-bottom: 40px;
  }

  .roadmap-header h1 {
    font-size: 2.5rem;
    margin-bottom: 16px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
  }

  .roadmap-header p {
    font-size: 1.1rem;
    color: rgba(255,255,255,0.8);
    margin: 0;
  }

  .learning-path-container {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 60px;
  }

  .roadmap-info {
    max-width: 800px;
    background: #2a2a2a;
    padding: 40px;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.3);
  }

  .roadmap-info h2 {
    color: #b78af0;
    margin-bottom: 30px;
    font-size: 1.8rem;
    text-align: center;
  }

  .course-description p {
    font-size: 1.1rem;
    line-height: 1.6;
    margin-bottom: 30px;
    color: #fff;
  }

  .course-highlights {
    margin-bottom: 40px;
  }

  .course-highlights h3 {
    color: #46cb2f;
    margin-bottom: 20px;
    font-size: 1.3rem;
  }

  .course-highlights ul {
    list-style: none;
    padding: 0;
  }

  .course-highlights li {
    padding: 12px 0;
    border-bottom: 1px solid #444;
    font-size: 1rem;
    line-height: 1.5;
  }

  .course-highlights li:last-child {
    border-bottom: none;
  }

  .course-highlights strong {
    color: #b78af0;
  }

  .course-structure h3 {
    color: #46cb2f;
    margin-bottom: 20px;
    font-size: 1.3rem;
  }

  .structure-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
  }

  .structure-item {
    background: #333;
    padding: 24px;
    border-radius: 8px;
    border-left: 4px solid #b78af0;
  }

  .structure-item h4 {
    color: #b78af0;
    margin-bottom: 12px;
    font-size: 1.1rem;
  }

  .structure-item p {
    color: rgba(255,255,255,0.8);
    font-size: 0.95rem;
    line-height: 1.5;
    margin: 0;
  }

  @media (max-width: 768px) {
    .roadmap-container {
      padding: 20px 10px;
    }

    .roadmap-header h1 {
      font-size: 2rem;
    }

    .roadmap-info {
      padding: 20px;
    }

    .structure-grid {
      grid-template-columns: 1fr;
    }
  }
</style> 