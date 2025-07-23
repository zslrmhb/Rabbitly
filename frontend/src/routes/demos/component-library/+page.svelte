<script lang="ts">
import Title from '../../../components/course/Title.svelte';
import ProgressBar from '../../../components/course/ProgressBar.svelte';
import ProgressTracker from '../../../components/course/ProgressTracker.svelte';
import LearningPath from '../../../components/course/LearningPath.svelte';
import PathRail from '../../../components/course/PathRail.svelte';
import Graph from '../../../components/course/Graph.svelte';
import AdvancedGraph from '../../../components/course/AdvancedGraph.svelte';
import MultipleChoice from '../../../components/course/MultipleChoice.svelte';
import MultipleChoiceM from '../../../components/course/MultipleChoiceM.svelte';
import TextBox from '../../../components/course/TextBox.svelte';
import DynamicLesson from '../../../components/course/DynamicLesson.svelte';
import CodeEditor from '../../../components/CodeEditor.svelte';
import RoadmapGraph from '../../../components/RoadmapGraph.svelte';
import StickyOutline from '../../../components/StickyOutline.svelte';

// Example data
const courseData = {
  id: 'course1',
  title: 'Sample Course',
  description: 'A sample course for demo purposes.',
  difficulty: 'beginner' as 'beginner',
  estimatedTime: 60,
  subTopics: [
    {
      id: 'sub1',
      title: 'Subtopic 1',
      description: 'First subtopic',
      lessons: [
        { id: 'l1', title: 'Lesson 1', type: 'text' as const, content: 'Lesson 1 content.' },
        { id: 'l2', title: 'Lesson 2', type: 'quiz' as const, questions: [{ id: 'q1', type: 'multiple-choice' as const, question: '2+2=?', options: ['3','4'], correctAnswer: '4' }] }
      ]
    }
  ],
  tags: ['demo']
};

const pathNodes = [
  { id: 'n1', subTopicId: 'sub1', componentId: 'Text', state: 'completed' as const, label: 'Text' },
  { id: 'n2', subTopicId: 'sub1', componentId: 'MCQ', state: 'current' as const, label: 'MCQ' },
  { id: 'n3', subTopicId: 'sub2', componentId: 'Code', state: 'future' as const, label: 'Code' },
  { id: 'n4', subTopicId: 'sub2', componentId: 'Graph', state: 'locked' as const, label: 'Graph', special: 'chest' as const }
];

const choices = [
  { label: 'A', text: '3' },
  { label: 'B', text: '4' },
  { label: 'C', text: '5' }
];

const lesson = {
  id: 'l1',
  title: 'Sample Lesson',
  type: 'text' as const,
  content: 'This is a sample lesson.'
};

const paragraphs = ['This is a sample paragraph for the TextBox component.'];
const instructions = 'Write a function to add two numbers.';
const roadmap = [
  { subTopicId: 'sub1', title: 'Subtopic 1', nodes: [ { id: 'n1', title: 'Node 1', type: 'lesson' } ] },
  { subTopicId: 'sub2', title: 'Subtopic 2', nodes: [ { id: 'n2', title: 'Node 2', type: 'quiz' } ] }
];

const subTopics = [
  { id: 'sub1', title: 'Subtopic 1' },
  { id: 'sub2', title: 'Subtopic 2' }
];

let selectedComponent = 'title';
</script>

<div class="component-library">
  <header class="library-header">
    <h1>Component Library</h1>
    <p>Interactive documentation for all available components</p>
  </header>

  <div class="library-content">
    <nav class="component-nav">
      <h3>Components</h3>
      <ul>
        <li><button class:active={selectedComponent === 'title'} on:click={() => selectedComponent = 'title'}>Title</button></li>
        <li><button class:active={selectedComponent === 'progress'} on:click={() => selectedComponent = 'progress'}>Progress Components</button></li>
        <li><button class:active={selectedComponent === 'path'} on:click={() => selectedComponent = 'path'}>Path Components</button></li>
        <li><button class:active={selectedComponent === 'interactive'} on:click={() => selectedComponent = 'interactive'}>Interactive Components</button></li>
        <li><button class:active={selectedComponent === 'visualization'} on:click={() => selectedComponent = 'visualization'}>Visualization Components</button></li>
      </ul>
    </nav>

    <main class="component-showcase">
      {#if selectedComponent === 'title'}
        <section>
          <h2>Title Component</h2>
          <p>Displays titles with different levels and styling.</p>
          <div class="component-demo">
            <Title text="Sample Title" level={1} />
            <Title text="Subtitle" level={2} />
            <Title text="Section Title" level={3} />
          </div>
          <div class="component-code">
            <h4>Usage:</h4>
            <pre><code>&lt;Title text="Your Title" level={1} /&gt;</code></pre>
            <h4>Props:</h4>
            <ul>
              <li><strong>text</strong>: string - The title text</li>
              <li><strong>level</strong>: number - Heading level (1-6)</li>
            </ul>
          </div>
        </section>
      {:else if selectedComponent === 'progress'}
        <section>
          <h2>Progress Components</h2>
          <div class="component-demo">
            <h3>ProgressBar</h3>
            <ProgressBar value={0.6} />
            
            <h3>ProgressTracker</h3>
            <ProgressTracker {courseData} />
          </div>
        </section>
      {:else if selectedComponent === 'path'}
        <section>
          <h2>Path Components</h2>
          <div class="component-demo">
            <h3>LearningPath</h3>
            <LearningPath nodes={pathNodes} activeNodeId="n2" />
            
            <h3>PathRail</h3>
            <PathRail nodes={pathNodes} currentNodeId="n2" dividerTitles={{ sub1: 'Subtopic 1', sub2: 'Subtopic 2' }} />
          </div>
        </section>
      {:else if selectedComponent === 'interactive'}
        <section>
          <h2>Interactive Components</h2>
          <div class="component-demo">
            <h3>MultipleChoice</h3>
            <MultipleChoice question="What is 2 + 2?" {choices} correctAnswer={['B']} />
            
            <h3>MultipleChoiceM (Multi-select)</h3>
            <MultipleChoiceM question="Select all even numbers" choices={[{label:'A',text:'2'},{label:'B',text:'3'},{label:'C',text:'4'}]} correctAnswer={["A","C"]} />
            
            <h3>TextBox</h3>
            <TextBox {paragraphs} />
            
            <h3>DynamicLesson</h3>
            <DynamicLesson {lesson} isActive={true} onComplete={() => {}} />
            
            <h3>CodeEditor</h3>
            <CodeEditor {instructions} />
          </div>
        </section>
      {:else if selectedComponent === 'visualization'}
        <section>
          <h2>Visualization Components</h2>
          <div class="component-demo">
            <h3>Graph</h3>
            <Graph />
            
            <h3>AdvancedGraph</h3>
            <AdvancedGraph />
            
            <h3>RoadmapGraph</h3>
            <RoadmapGraph {roadmap} />
            
            <h3>StickyOutline</h3>
            <StickyOutline {subTopics} />
          </div>
        </section>
      {/if}
    </main>
  </div>
</div>

<style>
.component-library {
  min-height: 100vh;
  background: #f8f9fa;
}

.library-header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 2rem;
  text-align: center;
}

.library-header h1 {
  margin: 0 0 0.5rem 0;
  font-size: 2.5rem;
}

.library-header p {
  margin: 0;
  opacity: 0.9;
  font-size: 1.1rem;
}

.library-content {
  display: flex;
  max-width: 1400px;
  margin: 0 auto;
  gap: 2rem;
  padding: 2rem;
}

.component-nav {
  width: 250px;
  background: white;
  border-radius: 12px;
  padding: 1.5rem;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  height: fit-content;
  position: sticky;
  top: 2rem;
}

.component-nav h3 {
  margin: 0 0 1rem 0;
  color: #333;
  font-size: 1.2rem;
}

.component-nav ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.component-nav li {
  margin-bottom: 0.5rem;
}

.component-nav button {
  width: 100%;
  padding: 0.75rem 1rem;
  border: none;
  background: none;
  text-align: left;
  cursor: pointer;
  border-radius: 8px;
  transition: all 0.2s ease;
  color: #666;
}

.component-nav button:hover {
  background: #f0f0f0;
  color: #333;
}

.component-nav button.active {
  background: var(--accent, #B78AF0);
  color: white;
}

.component-showcase {
  flex: 1;
  background: white;
  border-radius: 12px;
  padding: 2rem;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.component-showcase h2 {
  margin: 0 0 1rem 0;
  color: #333;
  font-size: 1.8rem;
}

.component-showcase p {
  color: #666;
  margin-bottom: 2rem;
  line-height: 1.6;
}

.component-demo {
  background: #f8f9fa;
  border-radius: 8px;
  padding: 2rem;
  margin-bottom: 2rem;
  border: 1px solid #e9ecef;
}

.component-demo h3 {
  margin: 0 0 1rem 0;
  color: #333;
  font-size: 1.2rem;
}

.component-code {
  background: #2d3748;
  color: #e2e8f0;
  border-radius: 8px;
  padding: 1.5rem;
}

.component-code h4 {
  margin: 0 0 0.5rem 0;
  color: #90cdf4;
}

.component-code pre {
  margin: 0.5rem 0 1rem 0;
  background: #1a202c;
  padding: 1rem;
  border-radius: 4px;
  overflow-x: auto;
}

.component-code code {
  color: #f7fafc;
  font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
}

.component-code ul {
  margin: 0.5rem 0;
  padding-left: 1.5rem;
}

.component-code li {
  margin-bottom: 0.25rem;
}

@media (max-width: 768px) {
  .library-content {
    flex-direction: column;
    padding: 1rem;
  }
  
  .component-nav {
    width: auto;
    position: static;
  }
}
</style> 