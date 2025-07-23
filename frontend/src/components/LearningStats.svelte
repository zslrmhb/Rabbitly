<script lang="ts">
  // TODO: Replace with real user stats data
  export let stats = {
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

  function getLevelTitle(level: number): string {
    if (level < 5) return 'Beginner';
    if (level < 10) return 'Intermediate';
    if (level < 15) return 'Advanced';
    return 'Expert';
  }

  function getLevelColor(level: number): string {
    if (level < 5) return '#10b981';
    if (level < 10) return '#f59e0b';
    if (level < 15) return '#ef4444';
    return '#8b5cf6';
  }

  function getWeeklyProgressPercentage(): number {
    return (stats.weeklyProgress / stats.weeklyGoal) * 100;
  }
</script>

<section class="stats-section">
  <div class="stats-header">
    <h2 class="stats-title">Your Learning Journey</h2>
    <p class="stats-subtitle">Track your progress and celebrate your achievements</p>
  </div>
  
  <div class="stats-grid">
    <!-- Streak Card -->
    <div class="stat-card streak">
      <div class="stat-icon">🔥</div>
      <div class="stat-content">
        <div class="stat-number">{stats.streak}</div>
        <div class="stat-label">Day Streak</div>
        <div class="stat-description">Keep the momentum going!</div>
      </div>
      <div class="stat-badge">Active</div>
    </div>

    <!-- Total Hours Card -->
    <div class="stat-card hours">
      <div class="stat-icon">⏱️</div>
      <div class="stat-content">
        <div class="stat-number">{stats.totalHours}</div>
        <div class="stat-label">Hours Learned</div>
        <div class="stat-description">Time well spent</div>
      </div>
      <div class="stat-badge">Growing</div>
    </div>

    <!-- Courses Completed Card -->
    <div class="stat-card courses">
      <div class="stat-icon">🎓</div>
      <div class="stat-content">
        <div class="stat-number">{stats.coursesCompleted}</div>
        <div class="stat-label">Courses Completed</div>
        <div class="stat-description">Knowledge gained</div>
      </div>
      <div class="stat-badge">Achievement</div>
    </div>

    <!-- Achievements Card -->
    <div class="stat-card achievements">
      <div class="stat-icon">🏆</div>
      <div class="stat-content">
        <div class="stat-number">{stats.achievementsEarned}</div>
        <div class="stat-label">Achievements</div>
        <div class="stat-description">Milestones reached</div>
      </div>
      <div class="stat-badge">Unlocked</div>
    </div>

    <!-- Current Level Card -->
    <div class="stat-card level">
      <div class="stat-icon">⭐</div>
      <div class="stat-content">
        <div class="stat-number">Level {stats.currentLevel}</div>
        <div class="stat-label">{getLevelTitle(stats.currentLevel)}</div>
        <div class="stat-description">You're making great progress!</div>
      </div>
      <div class="stat-badge" style="background: {getLevelColor(stats.currentLevel)};">{getLevelTitle(stats.currentLevel)}</div>
    </div>

    <!-- Weekly Goal Card -->
    <div class="stat-card weekly">
      <div class="stat-icon">📅</div>
      <div class="stat-content">
        <div class="stat-number">{stats.weeklyProgress}/{stats.weeklyGoal}</div>
        <div class="stat-label">Weekly Goal</div>
        <div class="stat-description">Lessons this week</div>
      </div>
      <div class="progress-ring">
        <svg width="40" height="40">
          <circle 
            class="progress-ring-bg" 
            cx="20" cy="20" r="16" 
            fill="none" 
            stroke="rgba(124, 58, 237, 0.2)" 
            stroke-width="3" 
          />
          <circle 
            class="progress-ring-bar" 
            cx="20" cy="20" r="16" 
            fill="none" 
            stroke="#7c3aed" 
            stroke-width="3" 
            stroke-dasharray="{2 * Math.PI * 16}" 
            stroke-dashoffset="{2 * Math.PI * 16 * (1 - getWeeklyProgressPercentage() / 100)}" 
            stroke-linecap="round" 
          />
        </svg>
      </div>
    </div>
  </div>

  <!-- Additional Stats Row -->
  <div class="additional-stats">
    <div class="additional-stat">
      <div class="additional-stat-number">{stats.totalLessons}</div>
      <div class="additional-stat-label">Total Lessons</div>
    </div>
    <div class="additional-stat">
      <div class="additional-stat-number">{stats.averageScore}%</div>
      <div class="additional-stat-label">Average Score</div>
    </div>
  </div>
</section>

<style>
.stats-section {
  margin: 4rem 0;
  padding: 2rem 0;
}

.stats-header {
  text-align: center;
  margin-bottom: 3rem;
}

.stats-title {
  font-family: 'Nunito', sans-serif;
  font-size: 2.2rem;
  font-weight: 800;
  color: #4A90E2;
  margin-bottom: 0.5rem;
}

.stats-subtitle {
  font-size: 1.1rem;
  color: #64748b;
  font-weight: 500;
  max-width: 500px;
  margin: 0 auto;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 1.5rem;
  margin-bottom: 2rem;
}

.stat-card {
  background: white;
  border-radius: 1.5rem;
  padding: 1.5rem;
  box-shadow: 0 4px 16px rgba(124, 58, 237, 0.08);
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  position: relative;
  overflow: hidden;
  border: 1px solid rgba(124, 58, 237, 0.06);
  display: flex;
  align-items: center;
  gap: 1rem;
}

.stat-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 4px;
  background: linear-gradient(90deg, #7c3aed 0%, #4A90E2 100%);
}

.stat-card:hover {
  transform: translateY(-4px) scale(1.02);
  box-shadow: 0 12px 32px rgba(124, 58, 237, 0.15);
}

.stat-card.streak::before {
  background: linear-gradient(90deg, #f59e0b 0%, #fbbf24 100%);
}

.stat-card.hours::before {
  background: linear-gradient(90deg, #10b981 0%, #34d399 100%);
}

.stat-card.courses::before {
  background: linear-gradient(90deg, #8b5cf6 0%, #a78bfa 100%);
}

.stat-card.achievements::before {
  background: linear-gradient(90deg, #ef4444 0%, #f87171 100%);
}

.stat-card.level::before {
  background: linear-gradient(90deg, #06b6d4 0%, #22d3ee 100%);
}

.stat-card.weekly::before {
  background: linear-gradient(90deg, #7c3aed 0%, #4A90E2 100%);
}

.stat-icon {
  font-size: 2.5rem;
  width: 60px;
  height: 60px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 1rem;
  background: rgba(124, 58, 237, 0.1);
  flex-shrink: 0;
}

.stat-content {
  flex: 1;
  min-width: 0;
}

.stat-number {
  font-family: 'Nunito', sans-serif;
  font-size: 2rem;
  font-weight: 800;
  color: #1e293b;
  line-height: 1;
  margin-bottom: 0.2rem;
}

.stat-label {
  font-size: 1rem;
  font-weight: 600;
  color: #4A90E2;
  margin-bottom: 0.2rem;
}

.stat-description {
  font-size: 0.9rem;
  color: #64748b;
  font-weight: 500;
}

.stat-badge {
  padding: 0.3rem 0.8rem;
  border-radius: 1rem;
  font-size: 0.8rem;
  font-weight: 700;
  color: white;
  background: linear-gradient(135deg, #7c3aed 0%, #4A90E2 100%);
  align-self: flex-start;
  margin-top: 0.5rem;
}

.progress-ring {
  position: relative;
  width: 40px;
  height: 40px;
  flex-shrink: 0;
}

.progress-ring svg {
  transform: rotate(-90deg);
}

.progress-ring-bg {
  opacity: 0.3;
}

.progress-ring-bar {
  transition: stroke-dashoffset 0.5s cubic-bezier(0.4, 0, 0.2, 1);
}

.additional-stats {
  display: flex;
  justify-content: center;
  gap: 3rem;
  margin-top: 2rem;
}

.additional-stat {
  text-align: center;
  padding: 1rem 2rem;
  background: rgba(124, 58, 237, 0.06);
  border-radius: 1rem;
  border: 1px solid rgba(124, 58, 237, 0.1);
}

.additional-stat-number {
  font-family: 'Nunito', sans-serif;
  font-size: 1.8rem;
  font-weight: 800;
  color: #4A90E2;
  margin-bottom: 0.2rem;
}

.additional-stat-label {
  font-size: 0.9rem;
  color: #64748b;
  font-weight: 600;
}

@media (max-width: 900px) {
  .stats-grid {
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 1rem;
  }
  
  .stat-card {
    padding: 1.2rem;
  }
  
  .stat-icon {
    width: 50px;
    height: 50px;
    font-size: 2rem;
  }
  
  .stat-number {
    font-size: 1.6rem;
  }
  
  .additional-stats {
    gap: 2rem;
  }
}

@media (max-width: 600px) {
  .stats-section {
    margin: 3rem 0;
    padding: 1.5rem 0;
  }
  
  .stats-title {
    font-size: 1.8rem;
  }
  
  .stats-subtitle {
    font-size: 1rem;
  }
  
  .stats-grid {
    grid-template-columns: 1fr;
    gap: 1rem;
  }
  
  .stat-card {
    padding: 1rem;
    flex-direction: column;
    text-align: center;
    gap: 0.8rem;
  }
  
  .stat-icon {
    width: 60px;
    height: 60px;
    font-size: 2.5rem;
  }
  
  .stat-badge {
    align-self: center;
    margin-top: 0;
  }
  
  .additional-stats {
    flex-direction: column;
    gap: 1rem;
    align-items: center;
  }
  
  .additional-stat {
    width: 100%;
    max-width: 300px;
  }
}
</style> 