<script lang="ts">
	import { onMount } from 'svelte';
	import Title from '../components/course/Title.svelte';
	// import ProgressBar from '../components/course/ProgressBar.svelte';
	import HeroSection from '../components/HeroSection.svelte';
	import ContinueLearning from '../components/ContinueLearning.svelte';
	import Testimonials from '../components/Testimonials.svelte';
	import RecommendedForYou from '../components/RecommendedForYou.svelte';
	import FeaturedCourses from '../components/FeaturedCourses.svelte';
	import LearningStats from '../components/LearningStats.svelte';
	import NewsletterSignup from '../components/NewsletterSignup.svelte';
	import Footer from '../components/Footer.svelte';

	// Available courses
	let courses = [
		{
			id: 'python-basics',
			title: 'Python for Beginners',
			instructor: 'Jane Doe',
			rating: 4.8,
			reviews: 1247,
			hours: 12,
			level: 'Beginner',
			price: 0,
			icon: '🐍',
			color: '#3776ab',
			progress: 0,
			completedLessons: 0,
			totalLessons: 24,
			description: 'Learn Python programming from scratch with hands-on projects and real-world examples.',
			skills: ['Python', 'Programming', 'Data Types', 'Control Flow']
		},
		{
			id: 'data-science',
			title: 'Data Science Fundamentals',
			instructor: 'John Smith',
			rating: 4.9,
			reviews: 892,
			hours: 18,
			level: 'Intermediate',
			price: 0,
			icon: '📊',
			color: '#ff6b6b',
			progress: 35,
			completedLessons: 8,
			totalLessons: 32,
			description: 'Master data analysis, visualization, and machine learning techniques.',
			skills: ['Data Analysis', 'Statistics', 'Machine Learning', 'Python']
		},
		{
			id: 'web-development',
			title: 'Web Development Bootcamp',
			instructor: 'Emily Chen',
			rating: 4.7,
			reviews: 1563,
			hours: 24,
			level: 'Beginner',
			price: 0,
			icon: '💻',
			color: '#4ecdc4',
			progress: 0,
			completedLessons: 0,
			totalLessons: 48,
			description: 'Build modern websites with HTML, CSS, JavaScript, and React.',
			skills: ['HTML', 'CSS', 'JavaScript', 'React']
		},
		{
			id: 'machine-learning',
			title: 'Machine Learning Essentials',
			instructor: 'Alex Kim',
			rating: 4.6,
			reviews: 734,
			hours: 20,
			level: 'Advanced',
			price: 0,
			icon: '🤖',
			color: '#45b7d1',
			progress: 0,
			completedLessons: 0,
			totalLessons: 36,
			description: 'Dive deep into machine learning algorithms and neural networks.',
			skills: ['Machine Learning', 'Neural Networks', 'Python', 'TensorFlow']
		},
		{
			id: 'excel-mastery',
			title: 'Excel Mastery',
			instructor: 'Sarah Johnson',
			rating: 4.5,
			reviews: 2103,
			hours: 8,
			level: 'Beginner',
			price: 0,
			icon: '📈',
			color: '#217346',
			progress: 0,
			completedLessons: 0,
			totalLessons: 16,
			description: 'Master Excel formulas, pivot tables, and data analysis.',
			skills: ['Excel', 'Data Analysis', 'Pivot Tables', 'Formulas']
		},
		{
			id: 'ui-ux-design',
			title: 'UI/UX Design Principles',
			instructor: 'Mike Wilson',
			rating: 4.8,
			reviews: 567,
			hours: 14,
			level: 'Intermediate',
			price: 0,
			icon: '🎨',
			color: '#ff9ff3',
			progress: 0,
			completedLessons: 0,
			totalLessons: 28,
			description: 'Learn user interface and user experience design fundamentals.',
			skills: ['UI Design', 'UX Design', 'Figma', 'Prototyping']
		}
	];

	// Categories for filtering
	let categories = ['All', 'Programming', 'Data Science', 'Web Development', 'Design', 'Business'];
	let selectedCategory = 'All';

	// User data (mock)
	let user = {
		name: 'Alex',
		avatar: 'https://placehold.co/40x40'
	};

	// Mock data for Continue Learning
	let isLoggedIn = true; // TODO: Replace with real auth check
	let userCourseInProgress = {
		id: 'data-science',
		title: 'Data Science Fundamentals',
		thumbnail: 'https://placehold.co/120x80',
		lastLesson: 'Lesson 8: Data Visualization with Matplotlib',
		progress: 0.35
	};

	// Mock data for RecommendedForYou
	let recommendedCourses = [
		{
			id: 'python-101',
			title: 'Python for Beginners',
			instructor: 'Jane Doe',
			rating: 4.8,
			image: 'https://placehold.co/120x80',
			progress: 0,
			isEnrolled: false
		},
		{
			id: 'ml-intro',
			title: 'Intro to Machine Learning',
			instructor: 'John Smith',
			rating: 4.7,
			image: 'https://placehold.co/120x80',
			progress: 0.2,
			isEnrolled: true
		},
		{
			id: 'excel-essentials',
			title: 'Excel Essentials',
			instructor: 'Emily Chen',
			rating: 4.6,
			image: 'https://placehold.co/120x80',
			progress: 0,
			isEnrolled: false
		},
		{
			id: 'web-dev',
			title: 'Web Development Bootcamp',
			instructor: 'Alex Kim',
			rating: 4.9,
			image: 'https://placehold.co/120x80',
			progress: 0.5,
			isEnrolled: true
		}
	];

	// Mock data for FeaturedCourses
	let featuredCourses = [
		{
			id: 'ai-masterclass',
			title: 'AI Masterclass: From Theory to Practice',
			instructor: 'Dr. Sarah Chen',
			rating: 4.9,
			reviews: 2847,
			hours: 32,
			level: 'Advanced',
			price: 99,
			originalPrice: 149,
			image: 'https://placehold.co/400x250',
			description: 'Master artificial intelligence with hands-on projects and real-world applications.',
			skills: ['Machine Learning', 'Deep Learning', 'Neural Networks', 'Python'],
			badge: 'Bestseller',
			discount: 33
		},
		{
			id: 'data-science-pro',
			title: 'Data Science Professional Certificate',
			instructor: 'Prof. Michael Rodriguez',
			rating: 4.8,
			reviews: 1892,
			hours: 45,
			level: 'Intermediate',
			price: 79,
			originalPrice: 119,
			image: 'https://placehold.co/400x250',
			description: 'Comprehensive data science program with industry-recognized certification.',
			skills: ['Data Analysis', 'Statistics', 'SQL', 'Python', 'Tableau'],
			badge: 'Certified',
			discount: 34
		},
		{
			id: 'web-dev-mastery',
			title: 'Complete Web Development Mastery',
			instructor: 'Alex Thompson',
			rating: 4.7,
			reviews: 3421,
			hours: 28,
			level: 'Beginner',
			price: 69,
			originalPrice: 99,
			image: 'https://placehold.co/400x250',
			description: 'Learn full-stack web development from scratch to deployment.',
			skills: ['HTML', 'CSS', 'JavaScript', 'React', 'Node.js'],
			badge: 'Popular',
			discount: 30
		}
	];

	// Mock data for LearningStats
	let userStats = {
		streak: 12,
		totalHours: 47,
		coursesCompleted: 3,
		achievementsEarned: 8,
		currentLevel: 5,
		totalLessons: 156,
		averageScore: 87,
		weeklyGoal: 5,
		weeklyProgress: 3
	};

	// Filter courses based on selected category
	$: filteredCourses = selectedCategory === 'All' 
		? courses 
		: courses.filter(course => {
			// Simple category matching - in real app, courses would have category property
			const courseCategories: Record<string, string[]> = {
				'Programming': ['python-basics', 'web-development'],
				'Data Science': ['data-science', 'machine-learning'],
				'Web Development': ['web-development'],
				'Design': ['ui-ux-design'],
				'Business': ['excel-mastery']
			};
			return courseCategories[selectedCategory]?.includes(course.id);
		});

	function handleHeroSearch(query: string) {
		// TODO: Implement search functionality
		console.log('Searching for:', query);
		// Filter courses based on search query
		// This is a simple implementation - in real app, you'd want more sophisticated search
		if (query.trim()) {
			const searchTerm = query.toLowerCase();
			filteredCourses = courses.filter(course => 
				course.title.toLowerCase().includes(searchTerm) ||
				course.instructor.toLowerCase().includes(searchTerm) ||
				course.description.toLowerCase().includes(searchTerm) ||
				course.skills.some(skill => skill.toLowerCase().includes(searchTerm))
			);
		} else {
			filteredCourses = courses;
		}
	}

	function handleResumeLearning() {
		// TODO: Replace with real navigation
		window.location.href = `/course/${userCourseInProgress.id}`;
	}

	function handleCategorySelect(category: string) {
		selectedCategory = category;
	}

	function handleCourseClick(courseId: string) {
		// TODO: Replace with real navigation
		window.location.href = `/course/${courseId}`;
	}

	function handleNewsletterSuccess(event: CustomEvent) {
		// TODO: Replace with real analytics tracking
		console.log('Newsletter signup successful:', event.detail.email);
		// You could send this to your analytics service
		// analytics.track('newsletter_signup', { email: event.detail.email });
	}
</script>

<svelte:head>
	<title>Rabbitly - Learn New Skills</title>
</svelte:head>

<div class="container">
	<!-- Header -->
	<header class="header">
		<div class="header-content">
			<div class="logo">Rabbitly</div>
			<div class="user-avatar">
				<img src={user.avatar} alt="User avatar" />
			</div>
		</div>
	</header>

	<!-- Hero Section -->
	<HeroSection onSearch={handleHeroSearch} />

	<!-- Continue Learning Section (for logged-in users) -->
	{#if isLoggedIn && userCourseInProgress}
		<ContinueLearning course={userCourseInProgress} onResume={handleResumeLearning} />
	{/if}

	<!-- Recommended for You Section -->
	<RecommendedForYou courses={recommendedCourses} />

	<!-- Featured Courses Section -->
	<FeaturedCourses courses={featuredCourses} />

	<!-- Learning Stats Section (for logged-in users) -->
	{#if isLoggedIn}
		<LearningStats stats={userStats} />
	{/if}

	<!-- Category Filter -->
	<div class="category-filter">
		{#each categories as category}
			<button 
				class="category-btn" 
				class:active={selectedCategory === category}
				on:click={() => handleCategorySelect(category)}
				aria-pressed={selectedCategory === category}
			>
				<span class="category-icon">
					{category === 'All' ? '📚' : 
					 category === 'Programming' ? '💻' :
					 category === 'Data Science' ? '📊' :
					 category === 'Web Development' ? '🌐' :
					 category === 'Design' ? '🎨' : '💼'}
				</span>
				<span>{category}</span>
			</button>
		{/each}
	</div>

	<!-- Courses Section -->
	<div class="courses-section">
		<h2 class="section-title">Explore Courses</h2>
		<div class="courses-grid">
			{#each filteredCourses as course (course.id)}
				<div class="course-card" on:click={() => handleCourseClick(course.id)}>
					<div class="course-icon-wrapper" style="background: linear-gradient(135deg, {course.color} 60%, #fff 100%);">
						<svg class="progress-ring" width="54" height="54">
							<circle class="progress-ring-bg" cx="27" cy="27" r="24" fill="none" stroke="#ede9fe" stroke-width="6" />
							<circle 
								class="progress-ring-bar" 
								cx="27" cy="27" r="24" 
								fill="none" 
								stroke="{course.color}" 
								stroke-width="6" 
								stroke-dasharray="{2 * Math.PI * 24}" 
								stroke-dashoffset="{2 * Math.PI * 24 * (1 - course.progress / 100)}" 
								stroke-linecap="round" 
							/>
						</svg>
						<span class="course-icon">{course.icon}</span>
					</div>
					
					<div class="course-content">
						<div class="course-header">
							<h3 class="course-title">{course.title}</h3>
							<div class="course-meta">
								<span class="course-instructor">{course.instructor}</span>
								<div class="course-rating">
									<span class="star">★</span>
									<span>{course.rating}</span>
									<span class="reviews">({course.reviews})</span>
								</div>
							</div>
						</div>
						
						<div class="course-details">
							<div class="course-stats">
								<span class="stat">{course.hours}h</span>
								<span class="stat">{course.level}</span>
								<span class="stat">{course.price === 0 ? 'Free' : `$${course.price}`}</span>
							</div>
							
							<div class="course-progress">
								<div class="progress-info">
									<span class="progress-text">{course.completedLessons}/{course.totalLessons} lessons</span>
									<span class="progress-percentage">{course.progress}% complete</span>
								</div>
								<div class="progress-bar-container">
									<div class="progress-bar" style="width: {course.progress}%; background-color: {course.color};"></div>
								</div>
							</div>
							
							<div class="course-footer">
								<button class="start-btn" on:click|stopPropagation={() => handleCourseClick(course.id)}>
									{course.progress > 0 ? 'Continue' : 'Start'}
								</button>
							</div>
						</div>
					</div>
				</div>
			{/each}
		</div>
	</div>

	<!-- Testimonials Section -->
	<Testimonials />

	<!-- Newsletter Signup Section -->
	<NewsletterSignup on:success={handleNewsletterSuccess} />
</div>

<!-- Footer -->
<Footer />

<style>
	/* Global Styles */
	* {
		margin: 0;
		padding: 0;
		box-sizing: border-box;
	}

	body {
		font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
		background: linear-gradient(135deg, var(--rabbitly-bg-secondary) 0%, var(--rabbitly-gray-200) 100%);
		color: var(--rabbitly-text-primary);
		line-height: 1.6;
	}

	.container {
		max-width: 1200px;
		margin: 0 auto;
		padding: 0 1.5rem;
	}

	/* Header Styles */
	.header {
		position: sticky;
		top: 0;
		z-index: 100;
		background: rgba(255, 255, 255, 0.95);
		backdrop-filter: blur(10px);
		border-bottom: 1px solid rgba(124, 58, 237, 0.1);
		padding: 1rem 0;
		box-shadow: 0 2px 8px rgba(124, 58, 237, 0.06);
	}

	.header-content {
		max-width: 1200px;
		margin: 0 auto;
		padding: 0 1.5rem;
		display: flex;
		justify-content: space-between;
		align-items: center;
	}

	.logo {
		font-family: 'Nunito', sans-serif;
		font-size: 1.8rem;
		font-weight: 800;
		color: #4A90E2;
		letter-spacing: -0.02em;
	}

	.user-avatar {
		width: 40px;
		height: 40px;
		border-radius: 50%;
		overflow: hidden;
		background: var(--rabbitly-gradient-primary);
		box-shadow: 0 2px 8px var(--rabbitly-shadow-medium);
	}

	.user-avatar img {
		width: 100%;
		height: 100%;
		object-fit: cover;
	}

	/* Category Filter Styles */
	.category-filter {
		background: rgba(124, 58, 237, 0.06);
		border-radius: 2rem;
		padding: 1rem 1.5rem;
		margin: 2rem 0;
		display: flex;
		gap: 0.8rem;
		overflow-x: auto;
		align-items: center;
		box-shadow: 0 2px 8px rgba(124, 58, 237, 0.04);
	}

	.category-btn {
		display: flex;
		align-items: center;
		gap: 0.5rem;
		padding: 0.7rem 1.2rem;
		border: none;
		border-radius: 1.5rem;
		background: rgba(255, 255, 255, 0.8);
		color: #7c3aed;
		font-weight: 600;
		font-size: 0.95rem;
		cursor: pointer;
		transition: all 0.2s cubic-bezier(0.4,0,0.2,1);
		white-space: nowrap;
		box-shadow: 0 2px 4px rgba(124, 58, 237, 0.08);
	}

	.category-btn:hover {
		background: rgba(255, 255, 255, 0.95);
		transform: translateY(-1px);
		box-shadow: 0 4px 12px rgba(124, 58, 237, 0.12);
	}

	.category-btn.active {
		background: var(--rabbitly-gradient-secondary);
		color: white;
		box-shadow: 0 4px 12px var(--rabbitly-shadow-medium);
	}

	.category-icon {
		font-size: 1.1rem;
	}

	/* Courses Section Styles */
	.courses-section {
		margin: 3rem 0;
		animation: fadeInUp 0.8s cubic-bezier(0.4,0,0.2,1);
	}

	.section-title {
		font-family: 'Nunito', sans-serif;
		font-size: 2rem;
		font-weight: 800;
		color: #4A90E2;
		margin-bottom: 2rem;
		text-align: center;
	}

	.courses-grid {
		display: grid;
		grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
		gap: 2rem;
	}

	.course-card {
		background: white;
		border-radius: 1.5rem;
		padding: 1.5rem;
		box-shadow: 0 4px 16px rgba(124, 58, 237, 0.08);
		transition: all 0.3s cubic-bezier(0.4,0,0.2,1);
		cursor: pointer;
		border: 1px solid rgba(124, 58, 237, 0.06);
		animation: fadeInUp 0.8s cubic-bezier(0.4,0,0.2,1);
	}

	.course-card:hover {
		transform: translateY(-8px) scale(1.02);
		box-shadow: 0 12px 32px rgba(124, 58, 237, 0.15);
		border-color: rgba(124, 58, 237, 0.1);
	}

	.course-icon-wrapper {
		width: 60px;
		height: 60px;
		border-radius: 1rem;
		display: flex;
		align-items: center;
		justify-content: center;
		margin-bottom: 1rem;
		position: relative;
		box-shadow: 0 4px 12px rgba(124, 58, 237, 0.1);
	}

	.progress-ring {
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
	}

	.progress-ring-bg {
		opacity: 0.3;
	}

	.progress-ring-bar {
		transition: stroke-dashoffset 0.5s cubic-bezier(0.4,0,0.2,1);
	}

	.course-icon {
		font-size: 1.8rem;
		position: relative;
		z-index: 1;
	}

	.course-content {
		display: flex;
		flex-direction: column;
		gap: 1rem;
	}

	.course-header {
		display: flex;
		flex-direction: column;
		gap: 0.5rem;
	}

	.course-title {
		font-family: 'Nunito', sans-serif;
		font-size: 1.3rem;
		font-weight: 700;
		color: #4A90E2;
		line-height: 1.3;
	}

	.course-meta {
		display: flex;
		justify-content: space-between;
		align-items: center;
		flex-wrap: wrap;
		gap: 0.5rem;
	}

	.course-instructor {
		font-size: 0.95rem;
		color: #7c3aed;
		font-weight: 600;
	}

	.course-rating {
		display: flex;
		align-items: center;
		gap: 0.3rem;
		font-size: 0.9rem;
		color: #F5A623;
		font-weight: 600;
	}

	.star {
		color: #F5A623;
		font-size: 1rem;
	}

	.reviews {
		color: #64748b;
		font-weight: 500;
	}

	.course-details {
		display: flex;
		flex-direction: column;
		gap: 1rem;
	}

	.course-stats {
		display: flex;
		gap: 1rem;
		flex-wrap: wrap;
	}

	.stat {
		font-size: 0.9rem;
		color: #64748b;
		font-weight: 500;
		padding: 0.3rem 0.8rem;
		background: rgba(124, 58, 237, 0.06);
		border-radius: 0.8rem;
	}

	.course-progress {
		display: flex;
		flex-direction: column;
		gap: 0.5rem;
	}

	.progress-info {
		display: flex;
		justify-content: space-between;
		align-items: center;
		font-size: 0.9rem;
	}

	.progress-text {
		color: #64748b;
		font-weight: 500;
	}

	.progress-percentage {
		font-weight: 700;
		color: #4A90E2;
	}

	.progress-bar-container {
		height: 8px;
		background-color: #e5e7eb;
		border-radius: 4px;
		overflow: hidden;
	}

	.progress-bar {
		height: 100%;
		border-radius: 4px;
		background-color: #7c3aed; /* Default color, overridden by course-card */
		transition: width 0.3s ease-in-out;
	}

	.course-footer {
		display: flex;
		justify-content: flex-end;
	}

	.start-btn {
		padding: 0.8rem 1.5rem;
		border: none;
		border-radius: 1.2rem;
		background: linear-gradient(135deg, #4A90E2 0%, #7c3aed 100%);
		color: white;
		font-weight: 700;
		font-size: 1rem;
		cursor: pointer;
		transition: all 0.2s cubic-bezier(0.4,0,0.2,1);
		box-shadow: 0 4px 12px rgba(74, 144, 226, 0.3);
	}

	.start-btn:hover {
		transform: translateY(-2px) scale(1.05);
		box-shadow: 0 8px 20px rgba(74, 144, 226, 0.4);
		background: linear-gradient(135deg, #7c3aed 0%, #4A90E2 100%);
	}

	/* Animations */
	@keyframes fadeInUp {
		from {
			opacity: 0;
			transform: translateY(30px);
		}
		to {
			opacity: 1;
			transform: translateY(0);
		}
	}

	/* Responsive Design */
	@media (max-width: 900px) {
		.container {
			padding: 0 1rem;
		}

		.courses-grid {
			grid-template-columns: 1fr;
			gap: 1.5rem;
		}

		.course-card {
			padding: 1.2rem;
		}

		.course-title {
			font-size: 1.2rem;
		}

		.section-title {
			font-size: 1.8rem;
		}

		.category-filter {
			padding: 0.8rem 1rem;
			gap: 0.6rem;
		}

		.category-btn {
			padding: 0.6rem 1rem;
			font-size: 0.9rem;
		}

		.logo {
			font-size: 1.6rem;
		}

		.user-avatar {
			width: 36px;
			height: 36px;
		}
	}

	@media (max-width: 600px) {
		.courses-grid {
			grid-template-columns: 1fr;
			gap: 1rem;
		}

		.course-card {
			padding: 1rem;
		}

		.course-meta {
			flex-direction: column;
			align-items: flex-start;
			gap: 0.3rem;
		}

		.course-stats {
			gap: 0.5rem;
		}

		.stat {
			font-size: 0.8rem;
			padding: 0.2rem 0.6rem;
		}

		.start-btn {
			padding: 0.7rem 1.2rem;
			font-size: 0.95rem;
		}

		.section-title {
			font-size: 1.6rem;
			margin-bottom: 1.5rem;
		}

		.category-filter {
			padding: 0.6rem 0.8rem;
			gap: 0.4rem;
		}

		.category-btn {
			padding: 0.5rem 0.8rem;
			font-size: 0.85rem;
		}

		.category-icon {
			font-size: 1rem;
		}
	}

	/* Accessibility */
	button:focus,
	.category-btn:focus,
	.start-btn:focus {
		outline: 2px solid #4A90E2;
		outline-offset: 2px;
	}

	.course-card:focus-within {
		outline: 2px solid #4A90E2;
		outline-offset: 2px;
	}
</style>
