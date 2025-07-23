# Component Example Usages

This page provides example usages for each component in the library, including prop explanations and code samples. Use this as a reference for implementing and documenting new components.

---

## ProgressBar

**Description:**
A visual progress indicator, typically used to show completion percentage.

**Parameters:**
- `value` (number, required): The progress value between 0 and 1 (e.g., 0.6 for 60%).

**Example Usage:**
```svelte
<script lang="ts">
  import ProgressBar from '../../../components/course/ProgressBar.svelte';
</script>

<ProgressBar value={0.6} />
```

---

## LearningPath

**Description:**
An interactive learning path component with streak, daily mission, rank, and a scrollable path section.

**Parameters:**
- `nodes` (PathNode[], required): The nodes representing steps in the learning path.
- `activeNodeId` (string, optional): The currently active node's ID.
- `streakDays` (number, optional): Number of consecutive learning days (default: 5).
- `dailyMission` (string, optional): The current daily mission (default: "Complete 3 lessons today").
- `rank` (object, optional): Rank info, e.g. `{ position: 1250, total: 5000, percentile: 75 }`.

**Example Usage:**
```svelte
<script lang="ts">
  import LearningPath from '../../../components/course/LearningPath.svelte';
  const pathNodes = [
    { id: 'n1', subTopicId: 'sub1', componentId: 'Text', state: 'completed', label: 'Text' },
    { id: 'n2', subTopicId: 'sub1', componentId: 'MCQ', state: 'current', label: 'MCQ' },
    { id: 'n3', subTopicId: 'sub2', componentId: 'Code', state: 'future', label: 'Code' }
  ];
</script>

<LearningPath
  nodes={pathNodes}
  activeNodeId="n2"
  streakDays={7}
  dailyMission="Finish 2 quizzes"
  rank={{ position: 100, total: 2000, percentile: 5 }}
/>
```

---

## MultipleChoice

**Description:**
A single-select multiple choice quiz component.

**Parameters:**
- `question` (string, required): The question text.
- `choices` (array, required): Array of `{ label: string, text: string }` for each option.
- `correctAnswer` (array, required): Array of correct answer labels (e.g., `["B"]`).

**Example Usage:**
```svelte
<script lang="ts">
  import MultipleChoice from '../../../components/course/MultipleChoice.svelte';
  const choices = [
    { label: 'A', text: '3' },
    { label: 'B', text: '4' },
    { label: 'C', text: '5' }
  ];
</script>

<MultipleChoice
  question="What is 2 + 2?"
  {choices}
  correctAnswer={["B"]}
/>
```

---

## How to Write an Example for a New Component

1. **Import the component** at the top of your Svelte file:
   ```svelte
   <script lang="ts">
     import MyComponent from '...';
   </script>
   ```
2. **Prepare any required data or props** as variables in your script block.
3. **Use the component** in your markup, passing the props:
   ```svelte
   <MyComponent prop1={value1} prop2={value2} />
   ```
4. **Document the parameters**:
   - List each prop, its type, and a short description.
5. **Add a code block** showing the example usage.
6. **Add a short description** of what the component does.

**Example Template:**

```
## MyComponent

**Description:**
A short description of what this component does.

**Parameters:**
- `prop1` (type, required/optional): Description
- `prop2` (type, required/optional): Description

**Example Usage:**
```svelte
<script lang="ts">
  import MyComponent from '...';
  // any setup
</script>

<MyComponent prop1={...} prop2={...} />
```
``` 