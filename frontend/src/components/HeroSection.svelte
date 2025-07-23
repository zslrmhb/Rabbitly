<script lang="ts">
  export let onSearch: (query: string) => void = () => {};
  let search = '';
  // TODO: Replace trendingTopics with real data
  let trendingTopics = ['Python', 'Data Science', 'Web Development', 'AI', 'Excel'];
</script>

<section class="hero">
  <div class="hero-content">
    <h1 class="hero-title">Learning that moves you forward</h1>
    <p class="hero-subtitle">Discover new skills, deepen your knowledge, and unlock your potential with <span class="brand">Rabbitly</span>.</p>
    <div class="search-bar">
      <input
        type="text"
        placeholder="What do you want to learn today?"
        bind:value={search}
        on:keydown={(e) => e.key === 'Enter' && onSearch(search)}
        aria-label="Search courses"
      />
      <button on:click={() => onSearch(search)} aria-label="Search">Search</button>
    </div>
    <div class="trending-topics">
      <span>Trending:</span>
      {#each trendingTopics as topic}
        <button class="trending-btn">{topic}</button>
      {/each}
    </div>
  </div>
  <div class="hero-illustration">
    <!-- TODO: Add mascot or illustration here -->
    <div class="mascot-placeholder">🐰</div>
  </div>
</section>

<style>
.hero {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 2.5rem;
  min-height: 340px;
  background: linear-gradient(135deg, #f3e8ff 0%, #e0e7ff 100%);
  border-radius: 2.5rem;
  box-shadow: 0 4px 32px rgba(124, 58, 237, 0.06);
  padding: 3.5rem 2.5rem;
  margin-bottom: 2.5rem;
}
.hero-content {
  flex: 2;
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}
.hero-title {
  font-family: 'Nunito', sans-serif;
  font-size: 2.8rem;
  font-weight: 900;
  color: #4A90E2;
  margin: 0;
  letter-spacing: 0.01em;
}
.hero-subtitle {
  font-family: 'Inter', sans-serif;
  font-size: 1.35rem;
  color: #333;
  margin: 0;
  font-weight: 500;
}
.brand {
  color: #F5A623;
  font-weight: 700;
}
.search-bar {
  display: flex;
  align-items: center;
  gap: 0.7rem;
  margin-top: 1.2rem;
}
.search-bar input {
  flex: 1;
  padding: 1rem 1.2rem;
  border-radius: 1.5rem;
  border: none;
  font-size: 1.1rem;
  background: #fff;
  box-shadow: 0 2px 8px rgba(124, 58, 237, 0.04);
  outline: none;
  color: #333;
  font-family: 'Inter', sans-serif;
}
.search-bar input:focus {
  outline: 2px solid #4A90E2;
}
.search-bar button {
  padding: 0.9rem 2.1rem;
  border-radius: 1.5rem;
  border: none;
  background: linear-gradient(90deg, #F5A623 0%, #F8E71C 100%);
  color: #fff;
  font-weight: 700;
  font-size: 1.1rem;
  cursor: pointer;
  box-shadow: 0 2px 8px rgba(245, 166, 35, 0.08);
  transition: background 0.18s, color 0.18s, transform 0.18s;
}
.search-bar button:hover {
  background: linear-gradient(90deg, #F8E71C 0%, #F5A623 100%);
  color: #fff;
  transform: scale(1.07);
}
.trending-topics {
  display: flex;
  align-items: center;
  gap: 0.7rem;
  margin-top: 1.1rem;
  font-size: 1.05rem;
  color: #4A90E2;
  font-weight: 600;
}
.trending-btn {
  background: #fff;
  color: #4A90E2;
  border: 1.5px solid #F5A623;
  border-radius: 1.2rem;
  padding: 0.5rem 1.3rem;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: background 0.18s, color 0.18s, border 0.18s;
}
.trending-btn:hover {
  background: #F5A623;
  color: #fff;
  border-color: #F5A623;
}
.hero-illustration {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
}
.mascot-placeholder {
  font-size: 5rem;
  background: #fff;
  border-radius: 50%;
  width: 120px;
  height: 120px;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 2px 16px rgba(245, 166, 35, 0.08);
}
@media (max-width: 900px) {
  .hero {
    flex-direction: column;
    gap: 1.5rem;
    padding: 2rem 1rem;
  }
  .hero-illustration {
    margin-top: 1.5rem;
  }
}
@media (max-width: 600px) {
  .hero {
    padding: 1rem 0.2rem;
    border-radius: 1.2rem;
    min-height: 180px;
  }
  .hero-title {
    font-size: 1.3rem;
  }
  .hero-subtitle {
    font-size: 1rem;
  }
  .mascot-placeholder {
    font-size: 2.2rem;
    width: 60px;
    height: 60px;
  }
}
</style> 