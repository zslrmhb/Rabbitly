<script lang="ts">
	import { onMount } from 'svelte';
	import Title from '../components/course/Title.svelte';
	import ProgressBar from '../components/course/ProgressBar.svelte';

	// Available courses
	let courses = [
		{
			id: 'data-science',
			title: "Introduction to Data Science",
			description: "Learn the fundamentals of data science, from basic statistics to machine learning",
			progress: 35,
			totalLessons: 42,
			completedLessons: 15,
			estimatedTime: "8-10 hours",
			level: "Beginner",
			category: "Technology",
			icon: "📊",
			color: "#667eea",
			popular: true
		},
		{
			id: 'python-programming',
			title: "Python Programming",
			description: "Master Python programming from basics to advanced concepts",
			progress: 0,
			totalLessons: 35,
			completedLessons: 0,
			estimatedTime: "6-8 hours",
			level: "Beginner",
			category: "Programming",
			icon: "🐍",
			color: "#10b981",
			popular: false
		},
		{
			id: 'web-development',
			title: "Web Development",
			description: "Build modern websites with HTML, CSS, and JavaScript",
			progress: 0,
			totalLessons: 28,
			completedLessons: 0,
			estimatedTime: "5-7 hours",
			level: "Beginner",
			category: "Programming",
			icon: "🌐",
			color: "#f59e0b",
			popular: false
		},
		{
			id: 'machine-learning',
			title: "Machine Learning Fundamentals",
			description: "Dive deep into machine learning algorithms and applications",
			progress: 0,
			totalLessons: 50,
			completedLessons: 0,
			estimatedTime: "12-15 hours",
			level: "Advanced",
			category: "Technology",
			icon: "🤖",
			color: "#8b5cf6",
			popular: true
		},
		{
			id: 'data-visualization',
			title: "Data Visualization",
			description: "Create compelling charts and graphs to tell data stories",
			progress: 0,
			totalLessons: 25,
			completedLessons: 0,
			estimatedTime: "4-6 hours",
			level: "Intermediate",
			category: "Technology",
			icon: "📈",
			color: "#ef4444",
			popular: false
		},
		{
			id: 'statistics',
			title: "Statistics for Beginners",
			description: "Learn essential statistical concepts and methods",
			progress: 0,
			totalLessons: 30,
			completedLessons: 0,
			estimatedTime: "6-8 hours",
			level: "Beginner",
			category: "Mathematics",
			icon: "📊",
			color: "#06b6d4",
			popular: false
		}
	];

	let user = {
		name: "Alex",
		avatar: "A",
		streak: 5,
		level: 3
	};

	let selectedCategory = "All";
	let categories = ["All", "Technology", "Programming", "Mathematics"];

	function goToCourse(courseId: string) {
		window.location.href = `/course/${courseId}`;
	}

	function goToProfile() {
		window.location.href = '/profile';
	}

	function filterByCategory(category: string) {
		selectedCategory = category;
	}

	$: filteredCourses = selectedCategory === "All" 
		? courses 
		: courses.filter(course => course.category === selectedCategory);
</script>

<svelte:head>
	<title>Rabbitly - Learn New Skills</title>
</svelte:head>

<div class="main-container">
	<!-- Header -->
	<header class="header">
		<div class="logo-section">
			<div class="logo">
				<span class="logo-icon">🐰</span>
				<span class="logo-text">Rabbitly</span>
			</div>
		</div>
		
		<div class="user-section">
			<div class="streak-info">
				<span class="streak-icon">🔥</span>
				<span class="streak-count">{user.streak} day streak</span>
			</div>
			<button class="profile-btn" on:click={goToProfile}>
				<div class="user-avatar">{user.avatar}</div>
			</button>
		</div>
	</header>

	<!-- Main Content -->
	<main class="main-content">
		<!-- Welcome Section -->
		<div class="welcome-section">
			<Title text="Welcome back, {user.name}!" level={1} />
			<p class="welcome-subtitle">Choose your next learning adventure</p>
		</div>

		<!-- Category Filter -->
		<div class="category-filter">
			{#each categories as category}
				<button 
					class="category-btn" 
					class:active={selectedCategory === category}
					on:click={() => filterByCategory(category)}
				>
					{category}
				</button>
			{/each}
		</div>

		<!-- Courses Grid -->
		<div class="courses-section">
			<div class="courses-grid">
				{#each filteredCourses as course (course.id)}
					<div class="course-card" class:popular={course.popular} on:click={() => goToCourse(course.id)}>
						{#if course.popular}
							<div class="popular-badge">🔥 Popular</div>
						{/if}
						
						<div class="course-header">
							<div class="course-icon" style="background-color: {course.color}">
								{course.icon}
							</div>
							<div class="course-info">
								<h3 class="course-title">{course.title}</h3>
								<div class="course-meta">
									<span class="course-level">{course.level}</span>
									<span class="course-category">{course.category}</span>
								</div>
							</div>
						</div>
						
						<p class="course-description">{course.description}</p>
						
						<div class="course-progress">
							<div class="progress-info">
								<span class="progress-text">{course.completedLessons}/{course.totalLessons} lessons</span>
								<span class="progress-percentage">{course.progress}% complete</span>
							</div>
							<ProgressBar value={course.progress / 100} />
						</div>
						
						<div class="course-footer">
							<span class="estimated-time">⏱️ {course.estimatedTime}</span>
							<button class="start-btn" class:has-progress={course.progress > 0}>
								{course.progress > 0 ? 'Continue' : 'Start'}
							</button>
						</div>
					</div>
				{/each}
			</div>
		</div>
	</main>
</div>

<style>
	.main-container {
		min-height: 100vh;
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
	}

	.header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding: 1rem 2rem;
		background: rgba(255, 255, 255, 0.1);
		backdrop-filter: blur(10px);
		border-bottom: 1px solid rgba(255, 255, 255, 0.2);
	}

	.logo-section {
		display: flex;
		align-items: center;
	}

	.logo {
		display: flex;
		align-items: center;
		gap: 0.5rem;
		color: white;
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
		color: white;
		font-size: 0.875rem;
	}

	.streak-icon {
		font-size: 1.25rem;
	}

	.profile-btn {
		background: rgba(255, 255, 255, 0.2);
		border: 1px solid rgba(255, 255, 255, 0.3);
		border-radius: 50%;
		width: 40px;
		height: 40px;
		display: flex;
		align-items: center;
		justify-content: center;
		cursor: pointer;
		transition: all 0.2s ease;
	}

	.profile-btn:hover {
		background: rgba(255, 255, 255, 0.3);
		transform: scale(1.05);
	}

	.user-avatar {
		color: white;
		font-weight: bold;
		font-size: 1.2rem;
	}

	.main-content {
		max-width: 1200px;
		margin: 0 auto;
		padding: 2rem;
	}

	.welcome-section {
		text-align: center;
		margin-bottom: 2rem;
		color: white;
	}

	.welcome-subtitle {
		color: rgba(255, 255, 255, 0.8);
		font-size: 1.125rem;
		margin: 0.5rem 0 0 0;
	}

	.category-filter {
		display: flex;
		justify-content: center;
		gap: 1rem;
		margin-bottom: 2rem;
		flex-wrap: wrap;
	}

	.category-btn {
		padding: 0.75rem 1.5rem;
		border: 2px solid rgba(255, 255, 255, 0.3);
		background: rgba(255, 255, 255, 0.1);
		color: white;
		border-radius: 25px;
		cursor: pointer;
		transition: all 0.2s ease;
		font-weight: 500;
		backdrop-filter: blur(10px);
	}

	.category-btn:hover {
		background: rgba(255, 255, 255, 0.2);
		transform: translateY(-2px);
	}

	.category-btn.active {
		background: white;
		color: #667eea;
		border-color: white;
	}

	.courses-section {
		margin-top: 2rem;
	}

	.courses-grid {
		display: grid;
		grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
		gap: 2rem;
	}

	.course-card {
		background: white;
		border-radius: 16px;
		padding: 1.5rem;
		box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
		transition: all 0.3s ease;
		cursor: pointer;
		position: relative;
		overflow: hidden;
	}

	.course-card:hover {
		transform: translateY(-5px);
		box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
	}

	.course-card.popular {
		border: 2px solid #f59e0b;
	}

	.popular-badge {
		position: absolute;
		top: 1rem;
		right: 1rem;
		background: #f59e0b;
		color: white;
		padding: 0.25rem 0.75rem;
		border-radius: 20px;
		font-size: 0.75rem;
		font-weight: 600;
	}

	.course-header {
		display: flex;
		align-items: center;
		gap: 1rem;
		margin-bottom: 1rem;
	}

	.course-icon {
		width: 48px;
		height: 48px;
		border-radius: 12px;
		display: flex;
		align-items: center;
		justify-content: center;
		font-size: 1.5rem;
		color: white;
	}

	.course-info {
		flex: 1;
	}

	.course-title {
		margin: 0;
		font-size: 1.25rem;
		font-weight: 600;
		color: #111827;
		line-height: 1.3;
	}

	.course-meta {
		display: flex;
		gap: 0.5rem;
		margin-top: 0.25rem;
	}

	.course-level,
	.course-category {
		font-size: 0.75rem;
		padding: 0.125rem 0.5rem;
		border-radius: 12px;
		font-weight: 500;
	}

	.course-level {
		background: #eff6ff;
		color: #3b82f6;
	}

	.course-category {
		background: #f0fdf4;
		color: #10b981;
	}

	.course-description {
		color: #6b7280;
		margin: 0 0 1rem 0;
		line-height: 1.5;
		font-size: 0.875rem;
	}

	.course-progress {
		margin-bottom: 1rem;
	}

	.progress-info {
		display: flex;
		justify-content: space-between;
		margin-bottom: 0.5rem;
	}

	.progress-text,
	.progress-percentage {
		font-size: 0.875rem;
		color: #6b7280;
	}

	.progress-percentage {
		font-weight: 500;
	}

	.course-footer {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}

	.estimated-time {
		font-size: 0.875rem;
		color: #6b7280;
	}

	.start-btn {
		padding: 0.5rem 1rem;
		border: none;
		border-radius: 8px;
		font-weight: 500;
		cursor: pointer;
		transition: all 0.2s ease;
		background: #3b82f6;
		color: white;
	}

	.start-btn:hover {
		background: #2563eb;
		transform: scale(1.05);
	}

	.start-btn.has-progress {
		background: #10b981;
	}

	.start-btn.has-progress:hover {
		background: #059669;
	}

	@media (max-width: 768px) {
		.header {
			padding: 1rem;
		}

		.main-content {
			padding: 1rem;
		}

		.courses-grid {
			grid-template-columns: 1fr;
			gap: 1rem;
		}

		.category-filter {
			gap: 0.5rem;
		}

		.category-btn {
			padding: 0.5rem 1rem;
			font-size: 0.875rem;
		}
	}
</style>
