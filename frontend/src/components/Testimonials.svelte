<script lang="ts">
  import { onMount } from 'svelte';
  import { fade } from 'svelte/transition';
  // TODO: Replace with real testimonials data
  export let testimonials = [
    {
      quote: 'Rabbitly helped me land my dream job in data science! The courses are engaging and easy to follow.',
      name: 'Alice Johnson',
      avatar: 'https://randomuser.me/api/portraits/women/44.jpg'
    },
    {
      quote: 'I love the interactive course cards and the personalized recommendations. Learning feels fun again!',
      name: 'Brian Lee',
      avatar: 'https://randomuser.me/api/portraits/men/32.jpg'
    },
    {
      quote: 'The progress tracking and streaks keep me motivated every day. Highly recommend Rabbitly!',
      name: 'Priya Patel',
      avatar: 'https://randomuser.me/api/portraits/women/68.jpg'
    },
    {
      quote: 'The best e-learning experience I have ever had. The UI is beautiful and fast.',
      name: 'Carlos Gomez',
      avatar: 'https://randomuser.me/api/portraits/men/76.jpg'
    }
  ];
  // TODO: Replace with real partner logos
  let partnerLogos = [
    'https://upload.wikimedia.org/wikipedia/commons/4/44/Microsoft_logo.svg',
    'https://upload.wikimedia.org/wikipedia/commons/2/2f/Google_2015_logo.svg',
    'https://upload.wikimedia.org/wikipedia/commons/0/08/Netflix_2015_logo.svg',
    'https://upload.wikimedia.org/wikipedia/commons/5/51/IBM_logo.svg'
  ];
  let current = 0;
  let visible = 3;
  // Responsive: adjust visible count
  function updateVisible() {
    if (window.innerWidth < 700) visible = 1;
    else if (window.innerWidth < 1100) visible = 2;
    else visible = 3;
  }
  onMount(() => {
    updateVisible();
    window.addEventListener('resize', updateVisible);
    return () => window.removeEventListener('resize', updateVisible);
  });
  function prev() {
    current = (current - 1 + testimonials.length) % testimonials.length;
  }
  function next() {
    current = (current + 1) % testimonials.length;
  }
</script>

<section class="testimonials-section">
  <h2 class="testimonials-title">What Learners Are Saying</h2>
  <div class="carousel-controls">
    <button class="carousel-btn" on:click={prev} aria-label="Previous testimonial">‹</button>
    <div class="testimonials-carousel">
      {#each Array(visible) as _, i}
        {#if testimonials[(current + i) % testimonials.length]}
          <div class="testimonial-card" transition:fade>
            <div class="testimonial-quote">“{testimonials[(current + i) % testimonials.length].quote}”</div>
            <div class="testimonial-user">
              <img class="testimonial-avatar" src={testimonials[(current + i) % testimonials.length].avatar} alt={testimonials[(current + i) % testimonials.length].name} />
              <span class="testimonial-name">{testimonials[(current + i) % testimonials.length].name}</span>
            </div>
          </div>
        {/if}
      {/each}
    </div>
    <button class="carousel-btn" on:click={next} aria-label="Next testimonial">›</button>
  </div>
  <div class="partner-logos">
    {#each partnerLogos as logo}
      <img class="partner-logo" src={logo} alt="Partner logo" loading="lazy" />
    {/each}
  </div>
</section>

<style>
.testimonials-section {
  margin: 4rem 0 2.5rem 0;
  padding: 2.5rem 0 1.5rem 0;
  background: linear-gradient(135deg, #f3e8ff 0%, #e0e7ff 100%);
  border-radius: 2rem;
  box-shadow: 0 4px 32px rgba(124, 58, 237, 0.06);
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 2rem;
}
.testimonials-title {
  font-family: 'Nunito', sans-serif;
  font-size: 2rem;
  font-weight: 800;
  color: #4A90E2;
  margin-bottom: 1.5rem;
}
.carousel-controls {
  display: flex;
  align-items: center;
  gap: 1.2rem;
}
.carousel-btn {
  background: #fff;
  border: none;
  border-radius: 50%;
  width: 44px;
  height: 44px;
  font-size: 2rem;
  color: #F5A623;
  box-shadow: 0 2px 8px rgba(245, 166, 35, 0.08);
  cursor: pointer;
  transition: background 0.18s, color 0.18s, transform 0.18s;
}
.carousel-btn:hover {
  background: #F5A623;
  color: #fff;
  transform: scale(1.07);
}
.testimonials-carousel {
  display: flex;
  gap: 2rem;
}
.testimonial-card {
  background: #fff;
  border-radius: 1.2rem;
  box-shadow: 0 2px 16px rgba(124, 58, 237, 0.06);
  padding: 2rem 1.5rem;
  min-width: 320px;
  max-width: 340px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 1.2rem;
  transition: box-shadow 0.18s, transform 0.18s;
}
.testimonial-quote {
  font-size: 1.1rem;
  color: #333;
  font-weight: 500;
  text-align: center;
  margin-bottom: 0.7rem;
}
.testimonial-user {
  display: flex;
  align-items: center;
  gap: 0.7rem;
}
.testimonial-avatar {
  width: 44px;
  height: 44px;
  border-radius: 50%;
  object-fit: cover;
  box-shadow: 0 2px 8px rgba(124, 58, 237, 0.08);
}
.testimonial-name {
  font-size: 1.05rem;
  color: #4A90E2;
  font-weight: 700;
}
.partner-logos {
  display: flex;
  align-items: center;
  gap: 2.5rem;
  margin-top: 2.5rem;
  flex-wrap: wrap;
  justify-content: center;
}
.partner-logo {
  height: 36px;
  width: auto;
  filter: grayscale(1) contrast(0.8);
  opacity: 0.7;
  transition: filter 0.18s, opacity 0.18s;
}
.partner-logo:hover {
  filter: grayscale(0) contrast(1);
  opacity: 1;
}
@media (max-width: 900px) {
  .testimonials-carousel {
    gap: 1rem;
  }
  .testimonial-card {
    min-width: 220px;
    max-width: 260px;
    padding: 1.2rem 0.7rem;
  }
  .partner-logos {
    gap: 1.2rem;
    margin-top: 1.2rem;
  }
}
@media (max-width: 600px) {
  .testimonials-section {
    padding: 1.2rem 0 0.7rem 0;
    border-radius: 1rem;
    gap: 1rem;
  }
  .testimonials-title {
    font-size: 1.1rem;
  }
  .testimonial-card {
    min-width: 160px;
    max-width: 98vw;
    padding: 0.7rem 0.3rem;
    border-radius: 0.7rem;
  }
  .carousel-btn {
    width: 32px;
    height: 32px;
    font-size: 1.2rem;
  }
  .partner-logo {
    height: 22px;
  }
}
</style> 