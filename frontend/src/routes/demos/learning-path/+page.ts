import type { PageLoad } from './$types';

export const load: PageLoad = async () => {
  return {
    title: 'Learning Path Demo',
    description: 'Duolingo-style learning path with scroll synchronization'
  };
}; 