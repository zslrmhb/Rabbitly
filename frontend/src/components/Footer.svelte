<script lang="ts">
  const currentYear = new Date().getFullYear();
  
  // TODO: Replace with real social media links
  const socialLinks = [
    { name: 'Twitter', url: '#', icon: '🐦' },
    { name: 'LinkedIn', url: '#', icon: '💼' },
    { name: 'YouTube', url: '#', icon: '📺' },
    { name: 'Instagram', url: '#', icon: '📷' }
  ];
  
  // TODO: Replace with real company links
  const companyLinks = [
    { name: 'About Us', url: '/about' },
    { name: 'Careers', url: '/careers' },
    { name: 'Press', url: '/press' },
    { name: 'Contact', url: '/contact' }
  ];
  
  const productLinks = [
    { name: 'Courses', url: '/courses' },
    { name: 'Learning Paths', url: '/paths' },
    { name: 'Certificates', url: '/certificates' },
    { name: 'Enterprise', url: '/enterprise' }
  ];
  
  const supportLinks = [
    { name: 'Help Center', url: '/help' },
    { name: 'Community', url: '/community' },
    { name: 'Feedback', url: '/feedback' },
    { name: 'Status', url: '/status' }
  ];
  
  const legalLinks = [
    { name: 'Privacy Policy', url: '/privacy' },
    { name: 'Terms of Service', url: '/terms' },
    { name: 'Cookie Policy', url: '/cookies' },
    { name: 'GDPR', url: '/gdpr' }
  ];
</script>

<footer class="footer">
  <div class="footer-container">
    <!-- Main Footer Content -->
    <div class="footer-main">
      <!-- Company Info -->
      <div class="footer-section company-info">
        <div class="footer-logo">
          <span class="logo-icon">🐰</span>
          <span class="logo-text">Rabbitly</span>
        </div>
        <p class="company-description">
          Empowering learners worldwide with cutting-edge courses and personalized learning experiences. 
          Join millions of students accelerating their careers with Rabbitly.
        </p>
        <div class="social-links">
          {#each socialLinks as link}
            <a href={link.url} class="social-link" aria-label={`Follow us on ${link.name}`}>
              <span class="social-icon">{link.icon}</span>
            </a>
          {/each}
        </div>
      </div>
      
      <!-- Quick Links -->
      <div class="footer-section">
        <h3 class="footer-title">Company</h3>
        <ul class="footer-links">
          {#each companyLinks as link}
            <li><a href={link.url} class="footer-link">{link.name}</a></li>
          {/each}
        </ul>
      </div>
      
      <div class="footer-section">
        <h3 class="footer-title">Product</h3>
        <ul class="footer-links">
          {#each productLinks as link}
            <li><a href={link.url} class="footer-link">{link.name}</a></li>
          {/each}
        </ul>
      </div>
      
      <div class="footer-section">
        <h3 class="footer-title">Support</h3>
        <ul class="footer-links">
          {#each supportLinks as link}
            <li><a href={link.url} class="footer-link">{link.name}</a></li>
          {/each}
        </ul>
      </div>
      
      <div class="footer-section">
        <h3 class="footer-title">Legal</h3>
        <ul class="footer-links">
          {#each legalLinks as link}
            <li><a href={link.url} class="footer-link">{link.name}</a></li>
          {/each}
        </ul>
      </div>
    </div>
    
    <!-- Footer Bottom -->
    <div class="footer-bottom">
      <div class="footer-bottom-content">
        <div class="copyright">
          <p>&copy; {currentYear} Rabbitly. All rights reserved.</p>
        </div>
        <div class="footer-actions">
          <button class="language-selector" aria-label="Select language">
            <span class="flag">🌍</span>
            <span>English</span>
            <span class="dropdown-arrow">▼</span>
          </button>
        </div>
      </div>
    </div>
  </div>
</footer>

<style>
.footer {
  background: linear-gradient(135deg, #1e293b 0%, #334155 100%);
  color: #f8fafc;
  margin-top: 4rem;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
}

.footer-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 1.5rem;
}

.footer-main {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr 1fr 1fr;
  gap: 3rem;
  padding: 3rem 0 2rem 0;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.footer-section {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.company-info {
  max-width: 300px;
}

.footer-logo {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-bottom: 1rem;
}

.logo-icon {
  font-size: 2rem;
}

.logo-text {
  font-family: 'Nunito', sans-serif;
  font-size: 1.5rem;
  font-weight: 800;
  color: #4A90E2;
}

.company-description {
  color: #cbd5e1;
  line-height: 1.6;
  font-size: 0.95rem;
  margin-bottom: 1.5rem;
}

.social-links {
  display: flex;
  gap: 1rem;
}

.social-link {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 40px;
  height: 40px;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 50%;
  color: #f8fafc;
  text-decoration: none;
  transition: all 0.2s ease;
  backdrop-filter: blur(10px);
}

.social-link:hover {
  background: rgba(255, 255, 255, 0.2);
  transform: translateY(-2px);
  color: #4A90E2;
}

.social-icon {
  font-size: 1.2rem;
}

.footer-title {
  font-family: 'Nunito', sans-serif;
  font-size: 1.1rem;
  font-weight: 700;
  color: #f8fafc;
  margin-bottom: 0.5rem;
}

.footer-links {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.footer-link {
  color: #cbd5e1;
  text-decoration: none;
  font-size: 0.95rem;
  font-weight: 500;
  transition: color 0.2s ease;
  padding: 0.2rem 0;
}

.footer-link:hover {
  color: #4A90E2;
}

.footer-bottom {
  padding: 2rem 0;
}

.footer-bottom-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 1rem;
}

.copyright {
  color: #94a3b8;
  font-size: 0.9rem;
  font-weight: 500;
}

.footer-actions {
  display: flex;
  gap: 1rem;
}

.language-selector {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.5rem 1rem;
  background: rgba(255, 255, 255, 0.1);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 0.8rem;
  color: #f8fafc;
  font-size: 0.9rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s ease;
  backdrop-filter: blur(10px);
}

.language-selector:hover {
  background: rgba(255, 255, 255, 0.15);
  border-color: rgba(255, 255, 255, 0.3);
}

.flag {
  font-size: 1rem;
}

.dropdown-arrow {
  font-size: 0.8rem;
  opacity: 0.7;
}

@media (max-width: 1024px) {
  .footer-main {
    grid-template-columns: 1fr 1fr;
    gap: 2rem;
  }
  
  .company-info {
    grid-column: 1 / -1;
    max-width: none;
    text-align: center;
  }
  
  .social-links {
    justify-content: center;
  }
}

@media (max-width: 768px) {
  .footer-main {
    grid-template-columns: 1fr;
    gap: 2rem;
    text-align: center;
  }
  
  .footer-section {
    align-items: center;
  }
  
  .footer-links {
    align-items: center;
  }
  
  .footer-bottom-content {
    flex-direction: column;
    text-align: center;
    gap: 1rem;
  }
}

@media (max-width: 480px) {
  .footer-container {
    padding: 0 1rem;
  }
  
  .footer-main {
    padding: 2rem 0 1.5rem 0;
    gap: 1.5rem;
  }
  
  .footer-bottom {
    padding: 1.5rem 0;
  }
  
  .logo-text {
    font-size: 1.3rem;
  }
  
  .company-description {
    font-size: 0.9rem;
  }
}
</style> 