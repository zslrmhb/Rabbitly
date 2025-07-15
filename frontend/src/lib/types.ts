export interface Lesson {
  id: string;
  title: string;
  type: 'text' | 'quiz' | 'project' | 'interactive';
  content?: string;
  questions?: Question[];
  projectDescription?: string;
  estimatedTime?: number; // in minutes
}

export interface Question {
  id: string;
  type: 'multiple-choice' | 'true-false' | 'fill-blank';
  question: string;
  options?: string[];
  correctAnswer: string | string[];
  explanation?: string;
}

export interface SubTopic {
  id: string;
  title: string;
  description: string;
  lessons: Lesson[];
  estimatedTime?: number; // in minutes
}

export interface CourseData {
  id: string;
  title: string;
  description: string;
  difficulty: 'beginner' | 'intermediate' | 'advanced';
  estimatedTime: number; // in minutes
  subTopics: SubTopic[];
  prerequisites?: string[];
  tags: string[];
}

export interface PathNode {
  id: string;
  subTopicId: string;                 // allows any string for flexibility
  componentId: string;                // maps to Text, MCQ, Code, Graph…
  state: "future" | "current" | "completed" | "locked";
  special?: "chest" | "badge";        // milestone visuals
  label?: string;                     // optional label for display
} 