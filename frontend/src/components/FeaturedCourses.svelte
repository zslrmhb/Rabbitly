<script lang="ts">
  // TODO: Replace with real featured courses data
  export let courses = [
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

  function handleEnroll(course: any) {
    // TODO: Replace with real enrollment logic
    console.log('Enrolling in course:', course.id);
    window.location.href = `/course/${course.id}/enroll`;
  }

  function handleViewAll() {
    // TODO: Replace with real navigation
    window.location.href = '/featured-courses';
  }
</script>

<section class="featured-section">
  <div class="featured-header">
    <h2 class="featured-title">Featured Courses</h2>
    <p class="featured-subtitle">Discover our most popular and highly-rated courses</p>
  </div>
  
  <div class="featured-grid">
    {#each courses as course}
      <div class="featured-card">
        {#if course.badge}
          <div class="badge {course.badge.toLowerCase()}">{course.badge}</div>
        {/if}
        
        <div class="card-image">
          <img src={course.image} alt={course.title} loading="lazy" />
          <div class="image-overlay">
            <div class="overlay-content">
              <span class="level-badge">{course.level}</span>
              <span class="hours-badge">{course.hours}h</span>
            </div>
          </div>
        </div>
        
        <div class="card-content">
          <div class="course-header">
            <h3 class="course-title">{course.title}</h3>
            <div class="instructor">by {course.instructor}</div>
          </div>
          
          <div class="course-meta">
            <div class="rating">
              <span class="stars">★★★★★</span>
              <span class="rating-text">{course.rating} ({course.reviews.toLocaleString()} reviews)</span>
            </div>
          </div>
          
          <p class="course-description">{course.description}</p>
          
          <div class="skills-container">
            {#each course.skills.slice(0, 3) as skill}
              <span class="skill-tag">{skill}</span>
            {/each}
            {#if course.skills.length > 3}
              <span class="skill-tag more">+{course.skills.length - 3} more</span>
            {/if}
          </div>
          
          <div class="pricing">
            <div class="price-info">
              <span class="current-price">${course.price}</span>
              {#if course.originalPrice > course.price}
                <span class="original-price">${course.originalPrice}</span>
                <span class="discount-tag">-{course.discount}%</span>
              {/if}
            </div>
            <button class="enroll-btn" on:click={() => handleEnroll(course)}>
              Enroll Now
            </button>
          </div>
        </div>
      </div>
    {/each}
  </div>
  
  <div class="view-all-container">
    <button class="view-all-btn" on:click={handleViewAll}>
      View All Featured Courses
      <span class="arrow">→</span>
    </button>
  </div>
</section>

<style>
.featured-section {
  margin: 4rem 0;
  padding: 3rem 0;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 2rem;
  position: relative;
  overflow: hidden;
}

.featured-section::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="50" cy="50" r="1" fill="white" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
  opacity: 0.3;
  pointer-events: none;
}

.featured-header {
  text-align: center;
  margin-bottom: 3rem;
  position: relative;
  z-index: 1;
}

.featured-title {
  font-family: 'Nunito', sans-serif;
  font-size: 2.5rem;
  font-weight: 800;
  color: white;
  margin-bottom: 0.5rem;
  text-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
}

.featured-subtitle {
  font-size: 1.2rem;
  color: rgba(255, 255, 255, 0.9);
  font-weight: 500;
  max-width: 600px;
  margin: 0 auto;
}

.featured-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(380px, 1fr));
  gap: 2rem;
  margin-bottom: 3rem;
  position: relative;
  z-index: 1;
}

.featured-card {
  background: white;
  border-radius: 1.5rem;
  overflow: hidden;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.15);
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  position: relative;
  cursor: pointer;
}

.featured-card:hover {
  transform: translateY(-12px) scale(1.02);
  box-shadow: 0 20px 48px rgba(0, 0, 0, 0.25);
}

.badge {
  position: absolute;
  top: 1rem;
  left: 1rem;
  padding: 0.5rem 1rem;
  border-radius: 2rem;
  font-size: 0.85rem;
  font-weight: 700;
  color: white;
  z-index: 2;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
}

.badge.bestseller {
  background: linear-gradient(135deg, #f59e0b 0%, #fbbf24 100%);
}

.badge.certified {
  background: linear-gradient(135deg, #10b981 0%, #34d399 100%);
}

.badge.popular {
  background: linear-gradient(135deg, #ef4444 0%, #f87171 100%);
}

.card-image {
  position: relative;
  height: 200px;
  overflow: hidden;
}

.card-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.featured-card:hover .card-image img {
  transform: scale(1.1);
}

.image-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(135deg, rgba(0, 0, 0, 0.3) 0%, rgba(0, 0, 0, 0.1) 100%);
  display: flex;
  align-items: flex-end;
  padding: 1rem;
}

.overlay-content {
  display: flex;
  gap: 0.5rem;
}

.level-badge, .hours-badge {
  padding: 0.3rem 0.8rem;
  border-radius: 1rem;
  font-size: 0.8rem;
  font-weight: 600;
  color: white;
  background: rgba(0, 0, 0, 0.6);
  backdrop-filter: blur(10px);
}

.card-content {
  padding: 1.5rem;
}

.course-header {
  margin-bottom: 1rem;
}

.course-title {
  font-family: 'Nunito', sans-serif;
  font-size: 1.4rem;
  font-weight: 700;
  color: #1e293b;
  line-height: 1.3;
  margin-bottom: 0.3rem;
}

.instructor {
  font-size: 1rem;
  color: #7c3aed;
  font-weight: 600;
}

.course-meta {
  margin-bottom: 1rem;
}

.rating {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.stars {
  color: #f59e0b;
  font-size: 1.1rem;
}

.rating-text {
  font-size: 0.95rem;
  color: #64748b;
  font-weight: 500;
}

.course-description {
  color: #64748b;
  line-height: 1.6;
  margin-bottom: 1.2rem;
  font-size: 0.95rem;
}

.skills-container {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
  margin-bottom: 1.5rem;
}

.skill-tag {
  padding: 0.3rem 0.8rem;
  background: rgba(124, 58, 237, 0.1);
  color: #7c3aed;
  border-radius: 1rem;
  font-size: 0.85rem;
  font-weight: 600;
}

.skill-tag.more {
  background: rgba(100, 116, 139, 0.1);
  color: #64748b;
}

.pricing {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 1rem;
  border-top: 1px solid #e2e8f0;
}

.price-info {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.current-price {
  font-size: 1.5rem;
  font-weight: 800;
  color: #10b981;
}

.original-price {
  font-size: 1rem;
  color: #94a3b8;
  text-decoration: line-through;
  font-weight: 500;
}

.discount-tag {
  padding: 0.2rem 0.6rem;
  background: #fef3c7;
  color: #d97706;
  border-radius: 0.5rem;
  font-size: 0.8rem;
  font-weight: 700;
}

.enroll-btn {
  padding: 0.8rem 1.5rem;
  background: linear-gradient(135deg, #7c3aed 0%, #4A90E2 100%);
  color: white;
  border: none;
  border-radius: 1rem;
  font-weight: 700;
  font-size: 1rem;
  cursor: pointer;
  transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
  box-shadow: 0 4px 12px rgba(124, 58, 237, 0.3);
}

.enroll-btn:hover {
  transform: translateY(-2px) scale(1.05);
  box-shadow: 0 8px 20px rgba(124, 58, 237, 0.4);
  background: linear-gradient(135deg, #4A90E2 0%, #7c3aed 100%);
}

.view-all-container {
  text-align: center;
  position: relative;
  z-index: 1;
}

.view-all-btn {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 1rem 2rem;
  background: rgba(255, 255, 255, 0.15);
  color: white;
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-radius: 2rem;
  font-weight: 700;
  font-size: 1.1rem;
  cursor: pointer;
  transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
  backdrop-filter: blur(10px);
}

.view-all-btn:hover {
  background: rgba(255, 255, 255, 0.25);
  border-color: rgba(255, 255, 255, 0.5);
  transform: translateY(-2px);
}

.arrow {
  font-size: 1.2rem;
  transition: transform 0.2s ease;
}

.view-all-btn:hover .arrow {
  transform: translateX(4px);
}

@media (max-width: 900px) {
  .featured-section {
    margin: 3rem 0;
    padding: 2rem 0;
  }
  
  .featured-title {
    font-size: 2rem;
  }
  
  .featured-subtitle {
    font-size: 1.1rem;
  }
  
  .featured-grid {
    grid-template-columns: 1fr;
    gap: 1.5rem;
  }
  
  .featured-card {
    max-width: 500px;
    margin: 0 auto;
  }
}

@media (max-width: 600px) {
  .featured-section {
    margin: 2rem 0;
    padding: 1.5rem 0;
    border-radius: 1rem;
  }
  
  .featured-title {
    font-size: 1.8rem;
  }
  
  .featured-subtitle {
    font-size: 1rem;
  }
  
  .card-content {
    padding: 1.2rem;
  }
  
  .course-title {
    font-size: 1.2rem;
  }
  
  .pricing {
    flex-direction: column;
    gap: 1rem;
    align-items: flex-start;
  }
  
  .enroll-btn {
    width: 100%;
    padding: 1rem;
  }
  
  .view-all-btn {
    padding: 0.8rem 1.5rem;
    font-size: 1rem;
  }
}
</style> 