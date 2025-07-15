<script lang="ts">
  import { writable, derived } from 'svelte/store';
  import type { CourseData, SubTopic, Lesson } from '$lib/types';

  export let courseData: CourseData;
  export let currentSubTopicId: string = '';

  // Progress store
  const progress = writable<Record<string, boolean>>({});
  
  // Derived stores for progress calculations
  export const subTopicProgress = derived(progress, ($progress) => {
    const subTopicProgress: Record<string, { completed: number; total: number; percentage: number }> = {};
    
    courseData.subTopics.forEach(subTopic => {
      const lessons = subTopic.lessons || [];
      const completed = lessons.filter(lesson => $progress[`${subTopic.id}-${lesson.id}`]).length;
      const total = lessons.length;
      
      subTopicProgress[subTopic.id] = {
        completed,
        total,
        percentage: total > 0 ? (completed / total) * 100 : 0
      };
    });
    
    return subTopicProgress;
  });

  export const overallProgress = derived([progress, subTopicProgress], ([$progress, $subTopicProgress]) => {
    const totalLessons = courseData.subTopics.reduce((sum, subTopic) => 
      sum + (subTopic.lessons?.length || 0), 0);
    const completedLessons = Object.keys($progress).length;
    
    return {
      completed: completedLessons,
      total: totalLessons,
      percentage: totalLessons > 0 ? (completedLessons / totalLessons) * 100 : 0
    };
  });

  // Methods to update progress
  export function markLessonComplete(subTopicId: string, lessonId: string) {
    progress.update(p => ({ ...p, [`${subTopicId}-${lessonId}`]: true }));
  }

  export function markLessonIncomplete(subTopicId: string, lessonId: string) {
    progress.update(p => {
      const newProgress = { ...p };
      delete newProgress[`${subTopicId}-${lessonId}`];
      return newProgress;
    });
  }

  export function isLessonComplete(subTopicId: string, lessonId: string): boolean {
    let currentProgress: Record<string, boolean> = {};
    progress.subscribe(p => { currentProgress = p; })();
    return currentProgress[`${subTopicId}-${lessonId}`] || false;
  }

  export function getSubTopicProgress(subTopicId: string) {
    let currentSubTopicProgress: Record<string, { completed: number; total: number; percentage: number }> = {};
    subTopicProgress.subscribe(p => { currentSubTopicProgress = p; })();
    return currentSubTopicProgress[subTopicId] || { completed: 0, total: 0, percentage: 0 };
  }

  export function getOverallProgress() {
    let currentOverallProgress: { completed: number; total: number; percentage: number } = { completed: 0, total: 0, percentage: 0 };
    overallProgress.subscribe(p => { currentOverallProgress = p; })();
    return currentOverallProgress;
  }

  // Expose the progress store for external access
  export { progress };
</script> 