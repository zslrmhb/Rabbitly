<script lang="ts">
import { page } from '$app/stores';
import { onMount } from 'svelte';
import courses from '$lib/data/courses.json';
import DuolingoPath from '../../../components/course/DuolingoPath.svelte';
import ProgressTracker from '../../../components/course/ProgressTracker.svelte';
import DynamicLesson from '../../../components/course/DynamicLesson.svelte';
import type { CourseData } from '$lib/types';

export let data: { courseId: string };

function findCourseByIdOrSlug(id: string): CourseData | undefined {
	// Try exact id match
	let course = courses.find(course => course.id === id);
	if (course) return course;
	// Try slugified match (replace dashes with underscores)
	course = courses.find(course => course.id.replace(/_/g, '-') === id);
	if (course) return course;
	// Try partial match (e.g. data-science matches data-science-intro)
	course = courses.find(course => course.id.startsWith(id));
	if (course) return course;
	return undefined;
}

const courseId = data.courseId || $page.params.id;
const courseData = findCourseByIdOrSlug(courseId) as CourseData;

if (!courseData) {
	throw new Error('Course not found');
}

let currentSubTopicId = '';
let activeSectionId = '';
let progressTracker: any;
let completedSubTopics: string[] = [];

onMount(() => {
	// Set initial active section
	if (courseData.subTopics.length > 0) {
		currentSubTopicId = courseData.subTopics[0].id;
	}
});

function handleLessonComplete(lessonId: string) {
	if (progressTracker) {
		progressTracker.markLessonComplete(currentSubTopicId, lessonId);
		// Update completed sub-topics
		updateCompletedSubTopics();
	}
}

function handleSectionChange(subTopicId: string) {
	currentSubTopicId = subTopicId;
}

function handlePathNodeClick(event: CustomEvent) {
	const { subTopicId } = event.detail;
	currentSubTopicId = subTopicId;
	// Scroll to the section
	const element = document.getElementById(subTopicId);
	if (element) {
		element.scrollIntoView({ behavior: 'smooth', block: 'start' });
	}
}

function updateCompletedSubTopics() {
	if (progressTracker) {
		completedSubTopics = courseData.subTopics.filter(subTopic => {
			const progress = progressTracker.getSubTopicProgress(subTopic.id);
			return progress.completed === progress.total && progress.total > 0;
		}).map(subTopic => subTopic.id);
	}
}

let user = { name: 'Alex', avatar: 'A', streak: 5, level: 3 };

function goToProfile() { window.location.href = '/profile'; }
function goBack() { window.location.href = '/courses'; }
</script>

<!-- Progress Tracker (hidden, just for state management) -->
<ProgressTracker 
	bind:this={progressTracker}
	{courseData}
	{currentSubTopicId}
/>

<div class="course-container">
	<header class="header">
		<div class="header-left">
			<button class="back-btn" on:click={goBack}>← Back to Courses</button>
			<div class="logo"><span class="logo-icon">🐰</span><span class="logo-text">Rabbitly</span></div>
		</div>
		<div class="user-section">
			<div class="streak-info"><span class="streak-icon">🔥</span><span class="streak-count">{user.streak} day streak</span></div>
			<button class="profile-btn" on:click={goToProfile}><div class="user-avatar">{user.avatar}</div></button>
		</div>
	</header>
	
	<div class="main-layout">
		<!-- Left side - Duolingo Path -->
		<aside class="path-sidebar">
			<DuolingoPath 
				subTopics={courseData.subTopics}
				{currentSubTopicId}
				{completedSubTopics}
				on:nodeClick={handlePathNodeClick}
			/>
		</aside>
		
		<!-- Center - Course content -->
		<main class="content-area">
			<div class="course-header">
				<h1 class="course-title">{courseData.title}</h1>
				<p class="course-description">{courseData.description}</p>
			</div>
			
			<div class="content-stream">
				{#each courseData.subTopics as subTopic, i}
					<section id={subTopic.id} class="section-block">
						<div class="section-header">
							<h2>{subTopic.title}</h2>
							<p class="section-description">{subTopic.description}</p>
						</div>
						
						{#each subTopic.lessons as lesson, lessonIndex}
							<DynamicLesson 
								{lesson}
								isActive={currentSubTopicId === subTopic.id}
								onComplete={handleLessonComplete}
							/>
						{/each}
					</section>
				{/each}
			</div>
		</main>
		
		<!-- Right side - Optional space for ads, help, etc. -->
		<aside class="right-sidebar">
			<!-- Future: Help panel, progress stats, etc. -->
		</aside>
	</div>
</div>

<style>
.course-container { 
	min-height: 100vh; 
	background: #f5f5f5; 
}

.header { 
	display: flex; 
	justify-content: space-between; 
	align-items: center; 
	padding: 1rem 2rem; 
	background: #f3f4f6; 
	border-bottom: 1px solid #d1d5db; 
}

.header-left { 
	display: flex; 
	align-items: center; 
	gap: 2rem; 
}

.back-btn { 
	background: #f5f5f5; 
	border: 1px solid #d1d5db; 
	color: #333; 
	padding: 0.5rem 1rem; 
	border-radius: 8px; 
	cursor: pointer; 
	font-weight: 500; 
}

.logo { 
	display: flex; 
	align-items: center; 
	gap: 0.5rem; 
	color: #333; 
	font-weight: bold; 
	font-size: 1.5rem; 
}

.logo-icon { 
	font-size: 2rem; 
}

.user-section { 
	display: flex; 
	align-items: center; 
	gap: 1rem; 
}

.streak-info { 
	display: flex; 
	align-items: center; 
	gap: 0.5rem; 
	color: #666; 
	font-size: 0.875rem; 
}

.streak-icon { 
	font-size: 1.25rem; 
}

.profile-btn { 
	background: #f5f5f5; 
	border: 1px solid #d1d5db; 
	border-radius: 50%; 
	width: 40px; 
	height: 40px; 
	display: flex; 
	align-items: center; 
	justify-content: center; 
	cursor: pointer; 
}

.user-avatar { 
	color: #333; 
	font-weight: bold; 
	font-size: 1.2rem; 
}

.main-layout { 
	display: grid;
	grid-template-columns: 200px 1fr 200px;
	max-width: 1400px; 
	margin: 0 auto; 
	padding: 2rem; 
	gap: 2rem; 
}

.path-sidebar {
	position: sticky;
	top: 2rem;
	align-self: flex-start;
	display: flex;
	justify-content: center;
}

.content-area {
	background: white;
	border-radius: 16px;
	padding: 2rem;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.course-header {
	margin-bottom: 2rem;
	padding-bottom: 1.5rem;
	border-bottom: 1px solid #e5e7eb;
}

.course-title {
	margin: 0 0 0.5rem 0;
	font-size: 2rem;
	font-weight: 700;
	color: #111827;
}

.course-description {
	margin: 0;
	color: #6b7280;
	line-height: 1.6;
	font-size: 1.1rem;
}

.content-stream {
	display: flex;
	flex-direction: column;
	gap: 3rem;
}

.section-block {
	margin-bottom: 2rem;
}

.section-header {
	margin-bottom: 1.5rem;
}

.section-header h2 {
	margin: 0 0 0.5rem 0;
	font-size: 1.5rem;
	font-weight: 600;
	color: #111827;
}

.section-description {
	margin: 0;
	color: #6b7280;
	line-height: 1.6;
}

.right-sidebar {
	position: sticky;
	top: 2rem;
	align-self: flex-start;
}

/* Responsive design */
@media (max-width: 1200px) {
	.main-layout {
		grid-template-columns: 180px 1fr 150px;
		gap: 1.5rem;
	}
}

@media (max-width: 768px) {
	.main-layout {
		grid-template-columns: 1fr;
		gap: 1rem;
	}
	
	.path-sidebar {
		position: static;
		order: 2;
	}
	
	.content-area {
		order: 1;
	}
	
	.right-sidebar {
		display: none;
	}
}
</style> 