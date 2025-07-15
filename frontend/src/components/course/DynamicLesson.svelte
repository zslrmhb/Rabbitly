<script lang="ts">
  import { createEventDispatcher } from 'svelte';
  import type { Lesson, Question } from '$lib/types';
  import TextBox from './TextBox.svelte';
  import MultipleChoice from './MultipleChoice.svelte';

  export let lesson: Lesson;
  export let isActive: boolean = false;
  export let onComplete: (lessonId: string) => void;

  const dispatch = createEventDispatcher();

  let isCompleted = false;

  function handleLessonComplete() {
    if (!isCompleted) {
      isCompleted = true;
      onComplete(lesson.id);
      dispatch('complete', { lessonId: lesson.id });
    }
  }

  function handleQuizComplete() {
    handleLessonComplete();
  }
</script>

<div class="lesson-container" class:active={isActive} class:completed={isCompleted}>
  <div class="lesson-header">
    <h3 class="lesson-title">{lesson.title}</h3>
    {#if lesson.estimatedTime}
      <span class="estimated-time">~{lesson.estimatedTime} min</span>
    {/if}
  </div>

  <div class="lesson-content">
    {#if lesson.type === 'text'}
      <TextBox 
        paragraphs={lesson.content ? [lesson.content] : []} 
      />
      <button class="btn btn-primary" on:click={handleLessonComplete}>
        Mark as Complete
      </button>
    {:else if lesson.type === 'quiz' && lesson.questions}
      {#each lesson.questions as question, index}
        <div class="question-container">
          <MultipleChoice 
            question={question.question}
            choices={question.options?.map((option, i) => ({ 
              label: String.fromCharCode(65 + i), 
              text: option 
            })) || []}
            correctAnswer={Array.isArray(question.correctAnswer) ? question.correctAnswer : [question.correctAnswer]}
            on:correct={handleQuizComplete}
          />
        </div>
      {/each}
    {:else if lesson.type === 'project'}
      <div class="project-container">
        <h4>Project: {lesson.title}</h4>
        {#if lesson.projectDescription}
          <p class="project-description">{lesson.projectDescription}</p>
        {/if}
        <div class="project-actions">
          <button 
            class="btn btn-primary" 
            on:click={handleLessonComplete}
          >
            Mark as Complete
          </button>
        </div>
      </div>
    {:else if lesson.type === 'interactive'}
      <div class="interactive-container">
        <h4>Interactive: {lesson.title}</h4>
        {#if lesson.content}
          <div class="interactive-content">{@html lesson.content}</div>
        {/if}
        <div class="interactive-actions">
          <button 
            class="btn btn-primary" 
            on:click={handleLessonComplete}
          >
            Complete Interactive
          </button>
        </div>
      </div>
    {/if}
  </div>

  {#if isCompleted}
    <div class="completion-indicator">
      <span class="checkmark">✓</span>
      <span>Completed</span>
    </div>
  {/if}
</div>

<style>
  .lesson-container {
    background: white;
    border-radius: 12px;
    padding: 24px;
    margin-bottom: 16px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    border: 2px solid transparent;
    transition: all 0.3s ease;
  }

  .lesson-container.active {
    border-color: #007bff;
    box-shadow: 0 4px 16px rgba(0, 123, 255, 0.2);
  }

  .lesson-container.completed {
    border-color: #28a745;
    background: linear-gradient(135deg, #f8fff9 0%, #ffffff 100%);
  }

  .lesson-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 16px;
  }

  .lesson-title {
    margin: 0;
    font-size: 1.25rem;
    font-weight: 600;
    color: #333;
  }

  .estimated-time {
    font-size: 0.875rem;
    color: #666;
    background: #f8f9fa;
    padding: 4px 8px;
    border-radius: 12px;
  }

  .lesson-content {
    margin-bottom: 16px;
  }

  .question-container {
    margin-bottom: 24px;
  }

  .project-container,
  .interactive-container {
    text-align: center;
  }

  .project-description {
    color: #666;
    margin-bottom: 20px;
    line-height: 1.6;
  }

  .project-actions,
  .interactive-actions {
    margin-top: 20px;
  }

  .btn {
    padding: 12px 24px;
    border: none;
    border-radius: 8px;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease;
  }

  .btn-primary {
    background: #007bff;
    color: white;
  }

  .btn-primary:hover {
    background: #0056b3;
    transform: translateY(-1px);
  }

  .completion-indicator {
    display: flex;
    align-items: center;
    gap: 8px;
    color: #28a745;
    font-weight: 500;
    font-size: 0.875rem;
  }

  .checkmark {
    font-size: 1.125rem;
    font-weight: bold;
  }

  .interactive-content {
    margin: 20px 0;
    padding: 20px;
    background: #f8f9fa;
    border-radius: 8px;
    min-height: 100px;
  }
</style> 