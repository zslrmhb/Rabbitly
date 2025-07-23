<script lang="ts">
// --- Course Lobby Skeleton ---
// Import core components for the lobby UI
import LearningPath from '../../../../components/course/LearningPath.svelte';
import PathRail from '../../../../components/course/PathRail.svelte';

// --- Placeholder/mock data for skeleton ---
// Replace with real data from your backend or store
const pathNodes = [
  // Example node structure. Replace with real course path data.
  { id: 'n1', subTopicId: 'sub1', componentId: 'Text', state: 'completed' as const, label: 'Text' },
  { id: 'n2', subTopicId: 'sub1', componentId: 'MCQ', state: 'current' as const, label: 'MCQ' },
  { id: 'n3', subTopicId: 'sub2', componentId: 'Code', state: 'future' as const, label: 'Code' },
  { id: 'n4', subTopicId: 'sub2', componentId: 'Graph', state: 'locked' as const, label: 'Graph', special: 'chest' as const }
];
const dividerTitles = { sub1: 'Subtopic 1', sub2: 'Subtopic 2' };

// TODO: Replace navItems with real navigation/actions as needed
const navItems = [
  { icon: '📚', label: 'Learning Hub', active: true },
  { icon: '👤', label: 'Profile', active: false },
  { icon: '⚙️', label: 'More', active: false }
];
</script>

<!--
  Example Course Lobby Skeleton
  - Left: LearningPath (course progress, streak, mission, rank)
  - Center/Right: PathRail (vertical progress)
  - Right: Navigation bar (customize as needed)
  Replace mock data and structure with real data and features for your app.
-->
<div class="course-progress-container">
  <div class="progress-section">
    <!-- TODO: Replace with real course title or user info -->
    <h2>Course Progress</h2>
    <!-- LearningPath: Pass real pathNodes and props in production -->
    <LearningPath nodes={pathNodes} activeNodeId="n2" />
  </div>
  
  <div class="path-rail-section">
    <!-- PathRail: Pass real pathNodes and dividerTitles in production -->
    <PathRail nodes={pathNodes} currentNodeId="n2" dividerTitles={dividerTitles} />
  </div>
  
  <!-- Right Navigation Bar (customize or replace as needed) -->
  <nav class="right-nav">
    {#each navItems as item}
      <button class="nav-item" class:active={item.active}>
        <div class="nav-icon">{item.icon}</div>
        <span class="nav-label">{item.label}</span>
      </button>
    {/each}
  </nav>
</div>

<style>
.course-progress-container {
  min-height: 100vh;
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  padding: 2rem;
  background: #f5f5f5;
  position: relative;
}

.progress-section {
  margin-left: 2rem;
  display: flex;
  flex-direction: column;
  gap: 2rem;
}

.progress-section h2 {
  margin: 0;
  color: #333;
  font-size: 1.5rem;
  font-weight: 600;
}

.path-rail-section {
  position: absolute;
  top: 50%;
  right: 35%;
  transform: translateY(-50%);
}

.right-nav {
  position: fixed;
  right: 0;
  top: 50%;
  transform: translateY(-50%);
  display: flex;
  flex-direction: column;
  gap: 1rem;
  padding: 1rem;
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  border-radius: 20px 0 0 20px;
  box-shadow: -2px 0 10px rgba(0, 0, 0, 0.1);
  z-index: 100;
}

.nav-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
  padding: 1rem;
  border: none;
  background: none;
  cursor: pointer;
  border-radius: 15px;
  transition: all 0.2s ease;
  min-width: 80px;
}

.nav-item:hover {
  background: rgba(183, 138, 240, 0.1);
  transform: scale(1.05);
}

.nav-item.active {
  background: var(--accent, #B78AF0);
  color: white;
}

.nav-icon {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  background: rgba(183, 138, 240, 0.1);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.5rem;
  transition: all 0.2s ease;
}

.nav-item.active .nav-icon {
  background: rgba(255, 255, 255, 0.2);
}

.nav-label {
  font-size: 0.75rem;
  font-weight: 500;
  text-align: center;
  line-height: 1.2;
}
</style> 