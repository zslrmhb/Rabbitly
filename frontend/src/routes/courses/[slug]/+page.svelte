<script lang="ts">
  import { page } from '$app/stores';
  import { onMount } from 'svelte';
  import ProgressBar from '../../../components/course/ProgressBar.svelte';
  import LearningPath from '../../../components/course/LearningPath.svelte';
  import type { PathNode } from '$lib/types';

  // Get course slug from URL
  $: courseSlug = $page.params.slug;

  // Course data - TODO: Replace with real API call
  let course = {
    id: 'python-basics',
    slug: courseSlug,
    title: 'Python for Beginners',
    subtitle: 'Learn Python programming from scratch with hands-on projects',
    instructor: {
      name: 'Jane Doe',
      title: 'Senior Software Engineer at Google',
      avatar: '/api/placeholder/60/60',
      rating: 4.9,
      students: 15420,
      courses: 8
    },
    rating: 4.8,
    reviews: 1247,
    enrolledStudents: 15420,
    lastUpdated: 'December 2024',
    language: 'English',
    subtitles: ['English', 'Spanish', 'French'],
    level: 'Beginner',
    duration: '12 hours',
    lectures: 156,
    downloadable: true,
    certificate: true,
    lifetimeAccess: true,
    mobileAccess: true,
    assignments: 24,
    price: 89.99,
    originalPrice: 199.99,
    discount: 55,
    currency: 'USD',
    description: `Master Python programming from the ground up! This comprehensive course is designed for complete beginners who want to learn Python programming and build real-world applications.

What makes this course special:
• Start from absolute zero - no prior programming experience needed
• Learn by doing with 50+ hands-on exercises and projects
• Build a portfolio of 10+ real applications
• Get lifetime access to all course materials and updates
• Join our community of 15,000+ Python developers

By the end of this course, you'll be able to:
• Write clean, efficient Python code
• Build web applications with Flask and Django
• Work with databases and APIs
• Create data analysis scripts
• Automate tasks and workflows
• Deploy applications to the cloud`,
    whatYouWillLearn: [
      'Write clean, efficient Python code from scratch',
      'Understand object-oriented programming concepts',
      'Build web applications with Flask and Django',
      'Work with databases, APIs, and external services',
      'Create data analysis and visualization scripts',
      'Automate tasks and workflows',
      'Deploy applications to cloud platforms',
      'Debug and troubleshoot code effectively',
      'Follow Python best practices and conventions',
      'Build a professional developer portfolio'
    ],
    requirements: [
      'No prior programming experience required',
      'A computer with internet connection',
      'Basic computer skills (using files and folders)',
      'Willingness to learn and practice regularly'
    ],
    targetAudience: [
      'Complete beginners who want to learn programming',
      'Students looking to start a career in software development',
      'Professionals wanting to add Python to their skillset',
      'Entrepreneurs who want to build their own applications',
      'Anyone interested in automation and data analysis'
    ],
    curriculum: [
      {
        title: 'Getting Started with Python',
        lectures: 12,
        duration: '1.5 hours',
        topics: [
          'Introduction to Python and its applications',
          'Setting up your development environment',
          'Your first Python program',
          'Understanding variables and data types',
          'Basic input and output operations'
        ]
      },
      {
        title: 'Control Flow and Functions',
        lectures: 18,
        duration: '2.5 hours',
        topics: [
          'Conditional statements (if, elif, else)',
          'Loops (for and while)',
          'Creating and using functions',
          'Function parameters and return values',
          'Scope and variable lifetime'
        ]
      },
      {
        title: 'Data Structures',
        lectures: 15,
        duration: '2 hours',
        topics: [
          'Lists and list operations',
          'Tuples and sets',
          'Dictionaries and key-value pairs',
          'List comprehensions',
          'Working with nested data structures'
        ]
      },
      {
        title: 'Object-Oriented Programming',
        lectures: 20,
        duration: '3 hours',
        topics: [
          'Classes and objects',
          'Inheritance and polymorphism',
          'Encapsulation and abstraction',
          'Magic methods and operator overloading',
          'Design patterns and best practices'
        ]
      },
      {
        title: 'File Handling and Modules',
        lectures: 10,
        duration: '1.5 hours',
        topics: [
          'Reading and writing files',
          'Working with different file formats',
          'Creating and importing modules',
          'Package management with pip',
          'Virtual environments'
        ]
      },
      {
        title: 'Web Development with Flask',
        lectures: 25,
        duration: '3.5 hours',
        topics: [
          'Introduction to web development',
          'Setting up Flask framework',
          'Creating routes and views',
          'Working with templates',
          'Forms and user input',
          'Database integration',
          'Deploying your web application'
        ]
      },
      {
        title: 'Data Analysis and Visualization',
        lectures: 22,
        duration: '3 hours',
        topics: [
          'Working with NumPy arrays',
          'Data manipulation with Pandas',
          'Creating charts with Matplotlib',
          'Statistical analysis basics',
          'Real-world data analysis projects'
        ]
      },
      {
        title: 'Final Projects',
        lectures: 34,
        duration: '4 hours',
        topics: [
          'Building a web scraper',
          'Creating a task management app',
          'Developing a data analysis dashboard',
          'Building a REST API',
          'Deploying applications to the cloud'
        ]
      }
    ],
    reviews: [
      {
        id: 1,
        user: 'Michael Chen',
        rating: 5,
        date: '2 weeks ago',
        title: 'Excellent course for beginners!',
        content: 'This course exceeded my expectations. Jane explains complex concepts in a very clear way, and the hands-on projects really help solidify the learning. I went from knowing zero Python to building my own web applications!',
        helpful: 45
      },
      {
        id: 2,
        user: 'Sarah Johnson',
        rating: 5,
        date: '1 month ago',
        title: 'Perfect for career transition',
        content: 'I was working in marketing and wanted to transition to tech. This course gave me the foundation I needed. The projects are practical and the instructor is very responsive to questions. Highly recommend!',
        helpful: 32
      },
      {
        id: 3,
        user: 'David Rodriguez',
        rating: 4,
        date: '3 weeks ago',
        title: 'Great content, could use more advanced topics',
        content: 'The course is well-structured and the instructor is knowledgeable. I would have liked to see more advanced topics covered, but for beginners, this is perfect. The community is also very helpful.',
        helpful: 18
      }
    ],
    isEnrolled: false,
    progress: 0
  };

  // Learning path nodes for course curriculum
  let pathNodes: PathNode[] = [
    { id: 'intro', subTopicId: 'A', componentId: 'intro', state: 'completed' },
    { id: 'basics', subTopicId: 'A', componentId: 'basics', state: 'current' },
    { id: 'functions', subTopicId: 'A', componentId: 'functions', state: 'future' },
    { id: 'data-structures', subTopicId: 'B', componentId: 'data-structures', state: 'locked' },
    { id: 'oop', subTopicId: 'B', componentId: 'oop', state: 'locked' },
    { id: 'web-dev', subTopicId: 'C', componentId: 'web-dev', state: 'locked' },
    { id: 'data-analysis', subTopicId: 'C', componentId: 'data-analysis', state: 'locked' },
    { id: 'projects', subTopicId: 'D', componentId: 'projects', state: 'locked' }
  ];

  let selectedTab = 'overview';
  let showFullDescription = false;
  let showAllReviews = false;

  onMount(() => {
    // TODO: Load course data from API based on courseSlug
    console.log('Loading course:', courseSlug);
  });

  function handleEnroll() {
    // TODO: Implement enrollment logic
    console.log('Enrolling in course:', course.id);
    course.isEnrolled = true;
  }

  function handleStartLearning() {
    // TODO: Navigate to first lesson
    console.log('Starting course:', course.id);
  }

  function handleTabChange(tab: string) {
    selectedTab = tab;
  }

  function formatPrice(price: number): string {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: course.currency
    }).format(price);
  }

  function calculateDiscountPercentage(): number {
    return Math.round(((course.originalPrice - course.price) / course.originalPrice) * 100);
  }
</script>

<svelte:head>
  <title>{course.title} - Rabbitly</title>
  <meta name="description" content={course.subtitle} />
</svelte:head>

<div class="course-detail-container">
  <!-- Course Header -->
  <header class="course-header">
    <div class="course-header-content">
      <div class="course-info">
        <nav class="breadcrumb">
          <a href="/courses">Courses</a>
          <span class="separator">›</span>
          <a href="/courses/programming">Programming</a>
          <span class="separator">›</span>
          <span class="current">{course.title}</span>
        </nav>
        
        <h1 class="course-title">{course.title}</h1>
        <p class="course-subtitle">{course.subtitle}</p>
        
        <div class="course-meta">
          <div class="meta-item">
            <span class="meta-label">Created by</span>
            <a href="#" class="instructor-link">
              <img src={course.instructor.avatar} alt={course.instructor.name} class="instructor-avatar" />
              <span>{course.instructor.name}</span>
            </a>
          </div>
          
          <div class="meta-item">
            <span class="meta-label">Last updated</span>
            <span>{course.lastUpdated}</span>
          </div>
          
          <div class="meta-item">
            <span class="meta-label">Language</span>
            <span>{course.language}</span>
          </div>
        </div>
        
        <div class="course-stats">
          <div class="stat">
            <span class="stat-value">{course.rating}</span>
            <div class="stars">
              {#each Array(5) as _, i}
                <span class="star {i < Math.floor(course.rating) ? 'filled' : ''}">★</span>
              {/each}
            </div>
            <span class="stat-label">({course.reviews.toLocaleString()} reviews)</span>
          </div>
          
          <div class="stat">
            <span class="stat-value">{course.enrolledStudents.toLocaleString()}</span>
            <span class="stat-label">students enrolled</span>
          </div>
          
          <div class="stat">
            <span class="stat-value">{course.duration}</span>
            <span class="stat-label">of content</span>
          </div>
        </div>
      </div>
      
      <div class="course-preview">
        <div class="preview-video">
          <div class="video-placeholder">
            <div class="play-button">▶</div>
            <span>Course Preview</span>
          </div>
        </div>
        
        <div class="course-card">
          <div class="price-section">
            <div class="price-info">
              <span class="current-price">{formatPrice(course.price)}</span>
              {#if course.originalPrice > course.price}
                <span class="original-price">{formatPrice(course.originalPrice)}</span>
                <span class="discount-badge">-{calculateDiscountPercentage()}%</span>
              {/if}
            </div>
            <div class="price-note">30-Day Money-Back Guarantee</div>
          </div>
          
          <div class="course-features">
            <div class="feature">
              <span class="feature-icon">✓</span>
              <span>Full lifetime access</span>
            </div>
            <div class="feature">
              <span class="feature-icon">✓</span>
              <span>Access on mobile and TV</span>
            </div>
            <div class="feature">
              <span class="feature-icon">✓</span>
              <span>Certificate of completion</span>
            </div>
            <div class="feature">
              <span class="feature-icon">✓</span>
              <span>{course.assignments} downloadable resources</span>
            </div>
          </div>
          
          {#if course.isEnrolled}
            <button class="enroll-btn enrolled" on:click={handleStartLearning}>
              Continue Learning
            </button>
            <div class="progress-info">
              <ProgressBar value={course.progress} />
              <span>{Math.round(course.progress * 100)}% Complete</span>
            </div>
          {:else}
            <button class="enroll-btn" on:click={handleEnroll}>
              Enroll Now
            </button>
          {/if}
          
          <div class="guarantee">
            <span class="guarantee-icon">🛡️</span>
            <span>30-Day Money-Back Guarantee</span>
          </div>
        </div>
      </div>
    </div>
  </header>

  <!-- Course Content -->
  <div class="course-content">
    <div class="content-main">
      <!-- Tab Navigation -->
      <nav class="tab-nav">
        <button 
          class="tab-btn {selectedTab === 'overview' ? 'active' : ''}"
          on:click={() => handleTabChange('overview')}
        >
          Overview
        </button>
        <button 
          class="tab-btn {selectedTab === 'curriculum' ? 'active' : ''}"
          on:click={() => handleTabChange('curriculum')}
        >
          Curriculum
        </button>
        <button 
          class="tab-btn {selectedTab === 'instructor' ? 'active' : ''}"
          on:click={() => handleTabChange('instructor')}
        >
          Instructor
        </button>
        <button 
          class="tab-btn {selectedTab === 'reviews' ? 'active' : ''}"
          on:click={() => handleTabChange('reviews')}
        >
          Reviews
        </button>
      </nav>

      <!-- Tab Content -->
      <div class="tab-content">
        {#if selectedTab === 'overview'}
          <div class="overview-tab">
            <div class="description-section">
              <h2>What you'll learn</h2>
              <div class="learning-objectives">
                {#each course.whatYouWillLearn as objective}
                  <div class="objective">
                    <span class="check-icon">✓</span>
                    <span>{objective}</span>
                  </div>
                {/each}
              </div>
            </div>

            <div class="description-section">
              <h2>Requirements</h2>
              <ul class="requirements-list">
                {#each course.requirements as requirement}
                  <li>{requirement}</li>
                {/each}
              </ul>
            </div>

            <div class="description-section">
              <h2>Description</h2>
              <div class="course-description">
                {#if showFullDescription}
                  <p>{course.description}</p>
                {:else}
                  <p>{course.description.substring(0, 300)}...</p>
                  <button class="read-more-btn" on:click={() => showFullDescription = true}>
                    Read more
                  </button>
                {/if}
              </div>
            </div>

            <div class="description-section">
              <h2>Who this course is for</h2>
              <ul class="audience-list">
                {#each course.targetAudience as audience}
                  <li>{audience}</li>
                {/each}
              </ul>
            </div>
          </div>
        {:else if selectedTab === 'curriculum'}
          <div class="curriculum-tab">
            <div class="curriculum-header">
              <h2>Course content</h2>
              <div class="curriculum-stats">
                <span>{course.lectures} lectures</span>
                <span>•</span>
                <span>{course.duration}</span>
              </div>
            </div>
            
            <div class="curriculum-sections">
              {#each course.curriculum as section, index}
                <div class="curriculum-section">
                  <div class="section-header">
                    <h3>{section.title}</h3>
                    <div class="section-meta">
                      <span>{section.lectures} lectures</span>
                      <span>•</span>
                      <span>{section.duration}</span>
                    </div>
                  </div>
                  <ul class="section-topics">
                    {#each section.topics as topic}
                      <li class="topic-item">
                        <span class="topic-icon">▶</span>
                        <span>{topic}</span>
                      </li>
                    {/each}
                  </ul>
                </div>
              {/each}
            </div>
          </div>
        {:else if selectedTab === 'instructor'}
          <div class="instructor-tab">
            <div class="instructor-profile">
              <div class="instructor-header">
                <img src={course.instructor.avatar} alt={course.instructor.name} class="instructor-avatar-large" />
                <div class="instructor-info">
                  <h2>{course.instructor.name}</h2>
                  <p class="instructor-title">{course.instructor.title}</p>
                  <div class="instructor-stats">
                    <div class="instructor-stat">
                      <span class="stat-value">{course.instructor.rating}</span>
                      <div class="stars">
                        {#each Array(5) as _, i}
                          <span class="star {i < Math.floor(course.instructor.rating) ? 'filled' : ''}">★</span>
                        {/each}
                      </div>
                      <span class="stat-label">Instructor Rating</span>
                    </div>
                    <div class="instructor-stat">
                      <span class="stat-value">{course.instructor.students.toLocaleString()}</span>
                      <span class="stat-label">Students</span>
                    </div>
                    <div class="instructor-stat">
                      <span class="stat-value">{course.instructor.courses}</span>
                      <span class="stat-label">Courses</span>
                    </div>
                  </div>
                </div>
              </div>
              
              <div class="instructor-bio">
                <h3>About {course.instructor.name}</h3>
                <p>Jane Doe is a Senior Software Engineer at Google with over 8 years of experience in software development and teaching. She has helped over 15,000 students learn programming and has created multiple best-selling courses on Rabbitly.</p>
                <p>Jane specializes in Python, web development, and machine learning. She believes in teaching through practical, real-world projects and making complex concepts accessible to beginners.</p>
              </div>
            </div>
          </div>
        {:else if selectedTab === 'reviews'}
          <div class="reviews-tab">
            <div class="reviews-header">
              <h2>Student Reviews</h2>
              <div class="reviews-summary">
                <div class="overall-rating">
                  <span class="rating-number">{course.rating}</span>
                  <div class="stars">
                    {#each Array(5) as _, i}
                      <span class="star {i < Math.floor(course.rating) ? 'filled' : ''}">★</span>
                    {/each}
                  </div>
                  <span class="rating-label">Course Rating</span>
                </div>
                <div class="total-reviews">
                  <span class="review-count">{course.reviews.toLocaleString()}</span>
                  <span class="review-label">reviews</span>
                </div>
              </div>
            </div>
            
            <div class="reviews-list">
              {#each (showAllReviews ? course.reviews : course.reviews.slice(0, 3)) as review}
                <div class="review-card">
                  <div class="review-header">
                    <div class="reviewer-info">
                      <div class="reviewer-avatar">{review.user.charAt(0)}</div>
                      <div class="reviewer-details">
                        <span class="reviewer-name">{review.user}</span>
                        <div class="review-rating">
                          {#each Array(5) as _, i}
                            <span class="star {i < review.rating ? 'filled' : ''}">★</span>
                          {/each}
                        </div>
                      </div>
                    </div>
                    <span class="review-date">{review.date}</span>
                  </div>
                  <h4 class="review-title">{review.title}</h4>
                  <p class="review-content">{review.content}</p>
                  <div class="review-actions">
                    <button class="helpful-btn">
                      <span>👍</span>
                      <span>Helpful ({review.helpful})</span>
                    </button>
                  </div>
                </div>
              {/each}
            </div>
            
            {#if course.reviews.length > 3}
              <button class="load-more-btn" on:click={() => showAllReviews = !showAllReviews}>
                {showAllReviews ? 'Show Less' : `Show All ${course.reviews.length} Reviews`}
              </button>
            {/if}
          </div>
        {/if}
      </div>
    </div>
  </div>
</div>

<style>
  .course-detail-container {
    min-height: 100vh;
    background: #f8fafc;
  }

  .course-header {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 2rem 0;
  }

  .course-header-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 1.5rem;
    display: grid;
    grid-template-columns: 1fr 400px;
    gap: 3rem;
    align-items: start;
  }

  .breadcrumb {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    font-size: 0.9rem;
    margin-bottom: 1rem;
  }

  .breadcrumb a {
    color: rgba(255, 255, 255, 0.8);
    text-decoration: none;
    transition: color 0.2s ease;
  }

  .breadcrumb a:hover {
    color: white;
  }

  .separator {
    color: rgba(255, 255, 255, 0.6);
  }

  .current {
    color: white;
    font-weight: 500;
  }

  .course-title {
    font-size: 2.5rem;
    font-weight: 800;
    margin: 0 0 0.5rem 0;
    line-height: 1.2;
  }

  .course-subtitle {
    font-size: 1.2rem;
    margin: 0 0 1.5rem 0;
    opacity: 0.9;
    line-height: 1.4;
  }

  .course-meta {
    display: flex;
    gap: 2rem;
    margin-bottom: 1.5rem;
  }

  .meta-item {
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
  }

  .meta-label {
    font-size: 0.85rem;
    opacity: 0.8;
  }

  .instructor-link {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    color: white;
    text-decoration: none;
    font-weight: 500;
  }

  .instructor-avatar {
    width: 24px;
    height: 24px;
    border-radius: 50%;
    object-fit: cover;
  }

  .course-stats {
    display: flex;
    gap: 2rem;
  }

  .stat {
    display: flex;
    align-items: center;
    gap: 0.5rem;
  }

  .stat-value {
    font-weight: 700;
    font-size: 1.1rem;
  }

  .stars {
    display: flex;
    gap: 0.1rem;
  }

  .star {
    color: #ffd700;
    font-size: 0.9rem;
  }

  .star.filled {
    color: #ffd700;
  }

  .stat-label {
    font-size: 0.85rem;
    opacity: 0.8;
  }

  .course-preview {
    display: flex;
    flex-direction: column;
    gap: 1rem;
  }

  .preview-video {
    background: #000;
    border-radius: 12px;
    overflow: hidden;
    aspect-ratio: 16/9;
  }

  .video-placeholder {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    background: linear-gradient(45deg, #667eea, #764ba2);
    color: white;
    cursor: pointer;
    transition: all 0.2s ease;
  }

  .video-placeholder:hover {
    transform: scale(1.02);
  }

  .play-button {
    font-size: 3rem;
    margin-bottom: 0.5rem;
  }

  .course-card {
    background: white;
    border-radius: 12px;
    padding: 1.5rem;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
  }

  .price-section {
    margin-bottom: 1.5rem;
  }

  .price-info {
    display: flex;
    align-items: center;
    gap: 1rem;
    margin-bottom: 0.5rem;
  }

  .current-price {
    font-size: 2rem;
    font-weight: 800;
    color: #1e293b;
  }

  .original-price {
    font-size: 1.2rem;
    color: #64748b;
    text-decoration: line-through;
  }

  .discount-badge {
    background: #ef4444;
    color: white;
    padding: 0.25rem 0.5rem;
    border-radius: 4px;
    font-size: 0.8rem;
    font-weight: 600;
  }

  .price-note {
    font-size: 0.85rem;
    color: #64748b;
  }

  .course-features {
    margin-bottom: 1.5rem;
  }

  .feature {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    margin-bottom: 0.5rem;
    font-size: 0.9rem;
  }

  .feature-icon {
    color: #10b981;
    font-weight: bold;
  }

  .enroll-btn {
    width: 100%;
    padding: 1rem;
    background: #4A90E2;
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 1.1rem;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.2s ease;
    margin-bottom: 1rem;
  }

  .enroll-btn:hover {
    background: #357abd;
    transform: translateY(-1px);
  }

  .enroll-btn.enrolled {
    background: #10b981;
  }

  .progress-info {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
    margin-bottom: 1rem;
  }

  .guarantee {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    font-size: 0.85rem;
    color: #64748b;
    text-align: center;
    justify-content: center;
  }

  .course-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem 1.5rem;
  }

  .content-main {
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    overflow: hidden;
  }

  .tab-nav {
    display: flex;
    border-bottom: 1px solid #e2e8f0;
  }

  .tab-btn {
    flex: 1;
    padding: 1rem 1.5rem;
    background: none;
    border: none;
    font-size: 1rem;
    font-weight: 500;
    color: #64748b;
    cursor: pointer;
    transition: all 0.2s ease;
    border-bottom: 2px solid transparent;
  }

  .tab-btn:hover {
    color: #4A90E2;
  }

  .tab-btn.active {
    color: #4A90E2;
    border-bottom-color: #4A90E2;
  }

  .tab-content {
    padding: 2rem;
  }

  .description-section {
    margin-bottom: 2rem;
  }

  .description-section h2 {
    font-size: 1.5rem;
    font-weight: 700;
    margin: 0 0 1rem 0;
    color: #1e293b;
  }

  .learning-objectives {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 1rem;
  }

  .objective {
    display: flex;
    align-items: flex-start;
    gap: 0.75rem;
    padding: 0.75rem;
    background: #f8fafc;
    border-radius: 8px;
  }

  .check-icon {
    color: #10b981;
    font-weight: bold;
    margin-top: 0.1rem;
  }

  .requirements-list,
  .audience-list {
    list-style: none;
    padding: 0;
  }

  .requirements-list li,
  .audience-list li {
    padding: 0.5rem 0;
    border-bottom: 1px solid #e2e8f0;
    position: relative;
    padding-left: 1.5rem;
  }

  .requirements-list li::before,
  .audience-list li::before {
    content: "•";
    position: absolute;
    left: 0;
    color: #4A90E2;
    font-weight: bold;
  }

  .course-description {
    line-height: 1.6;
    color: #475569;
  }

  .read-more-btn {
    background: none;
    border: none;
    color: #4A90E2;
    font-weight: 500;
    cursor: pointer;
    padding: 0;
    margin-top: 0.5rem;
  }

  .curriculum-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1.5rem;
  }

  .curriculum-stats {
    display: flex;
    gap: 0.5rem;
    color: #64748b;
    font-size: 0.9rem;
  }

  .curriculum-sections {
    display: flex;
    flex-direction: column;
    gap: 1rem;
  }

  .curriculum-section {
    border: 1px solid #e2e8f0;
    border-radius: 8px;
    overflow: hidden;
  }

  .section-header {
    padding: 1rem;
    background: #f8fafc;
    border-bottom: 1px solid #e2e8f0;
  }

  .section-header h3 {
    margin: 0 0 0.5rem 0;
    font-size: 1.1rem;
    font-weight: 600;
  }

  .section-meta {
    display: flex;
    gap: 0.5rem;
    font-size: 0.85rem;
    color: #64748b;
  }

  .section-topics {
    list-style: none;
    padding: 0;
    margin: 0;
  }

  .topic-item {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 0.75rem 1rem;
    border-bottom: 1px solid #f1f5f9;
  }

  .topic-item:last-child {
    border-bottom: none;
  }

  .topic-icon {
    color: #64748b;
    font-size: 0.8rem;
  }

  .instructor-profile {
    display: flex;
    flex-direction: column;
    gap: 2rem;
  }

  .instructor-header {
    display: flex;
    gap: 1.5rem;
    align-items: flex-start;
  }

  .instructor-avatar-large {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    object-fit: cover;
  }

  .instructor-info h2 {
    margin: 0 0 0.5rem 0;
    font-size: 1.5rem;
    font-weight: 700;
  }

  .instructor-title {
    color: #64748b;
    margin: 0 0 1rem 0;
  }

  .instructor-stats {
    display: flex;
    gap: 2rem;
  }

  .instructor-stat {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.25rem;
  }

  .instructor-bio h3 {
    margin: 0 0 1rem 0;
    font-size: 1.2rem;
    font-weight: 600;
  }

  .instructor-bio p {
    line-height: 1.6;
    color: #475569;
    margin-bottom: 1rem;
  }

  .reviews-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
  }

  .reviews-summary {
    display: flex;
    align-items: center;
    gap: 2rem;
  }

  .overall-rating {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.25rem;
  }

  .rating-number {
    font-size: 2rem;
    font-weight: 700;
    color: #1e293b;
  }

  .rating-label {
    font-size: 0.85rem;
    color: #64748b;
  }

  .total-reviews {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.25rem;
  }

  .review-count {
    font-size: 1.5rem;
    font-weight: 700;
    color: #1e293b;
  }

  .review-label {
    font-size: 0.85rem;
    color: #64748b;
  }

  .reviews-list {
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
  }

  .review-card {
    padding: 1.5rem;
    border: 1px solid #e2e8f0;
    border-radius: 8px;
    background: #f8fafc;
  }

  .review-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 1rem;
  }

  .reviewer-info {
    display: flex;
    align-items: center;
    gap: 0.75rem;
  }

  .reviewer-avatar {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background: #4A90E2;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: 600;
  }

  .reviewer-name {
    font-weight: 600;
    color: #1e293b;
  }

  .review-rating {
    display: flex;
    gap: 0.1rem;
    margin-top: 0.25rem;
  }

  .review-date {
    font-size: 0.85rem;
    color: #64748b;
  }

  .review-title {
    margin: 0 0 0.5rem 0;
    font-size: 1.1rem;
    font-weight: 600;
    color: #1e293b;
  }

  .review-content {
    line-height: 1.6;
    color: #475569;
    margin-bottom: 1rem;
  }

  .helpful-btn {
    background: none;
    border: none;
    color: #64748b;
    font-size: 0.85rem;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 0.25rem;
  }

  .load-more-btn {
    background: #4A90E2;
    color: white;
    border: none;
    padding: 0.75rem 1.5rem;
    border-radius: 8px;
    font-weight: 500;
    cursor: pointer;
    margin-top: 1rem;
    transition: background 0.2s ease;
  }

  .load-more-btn:hover {
    background: #357abd;
  }

  @media (max-width: 1024px) {
    .course-header-content {
      grid-template-columns: 1fr;
      gap: 2rem;
    }
    
    .course-preview {
      order: -1;
    }
  }

  @media (max-width: 768px) {
    .course-title {
      font-size: 2rem;
    }
    
    .course-meta {
      flex-direction: column;
      gap: 1rem;
    }
    
    .course-stats {
      flex-wrap: wrap;
      gap: 1rem;
    }
    
    .tab-nav {
      flex-wrap: wrap;
    }
    
    .tab-btn {
      flex: none;
      min-width: 120px;
    }
    
    .learning-objectives {
      grid-template-columns: 1fr;
    }
    
    .instructor-header {
      flex-direction: column;
      text-align: center;
    }
    
    .instructor-stats {
      justify-content: center;
    }
    
    .reviews-header {
      flex-direction: column;
      gap: 1rem;
      text-align: center;
    }
  }

  @media (max-width: 480px) {
    .course-header {
      padding: 1.5rem 0;
    }
    
    .course-header-content {
      padding: 0 1rem;
    }
    
    .course-content {
      padding: 1rem;
    }
    
    .tab-content {
      padding: 1rem;
    }
  }
</style> 