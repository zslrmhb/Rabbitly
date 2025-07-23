<script lang="ts">
  import { createEventDispatcher } from 'svelte';
  
  const dispatch = createEventDispatcher();
  
  let email = '';
  let isLoading = false;
  let isSubmitted = false;
  let errorMessage = '';
  
  // TODO: Replace with real newsletter signup logic
  async function handleSubmit() {
    if (!email.trim()) {
      errorMessage = 'Please enter your email address';
      return;
    }
    
    if (!isValidEmail(email)) {
      errorMessage = 'Please enter a valid email address';
      return;
    }
    
    isLoading = true;
    errorMessage = '';
    
    try {
      // TODO: Replace with real API call
      await new Promise(resolve => setTimeout(resolve, 1000)); // Simulate API call
      
      isSubmitted = true;
      dispatch('success', { email });
      
      // TODO: Send to analytics/tracking
      console.log('Newsletter signup:', email);
      
    } catch (error) {
      errorMessage = 'Something went wrong. Please try again.';
      console.error('Newsletter signup error:', error);
    } finally {
      isLoading = false;
    }
  }
  
  function isValidEmail(email: string): boolean {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
  }
  
  function handleEmailInput() {
    if (errorMessage) {
      errorMessage = '';
    }
  }
</script>

<section class="newsletter-section">
  <div class="newsletter-container">
    <div class="newsletter-content">
      <div class="newsletter-header">
        <h2 class="newsletter-title">Stay Ahead of the Curve</h2>
        <p class="newsletter-description">
          Get the latest course updates, learning tips, and exclusive content delivered to your inbox. 
          Join thousands of learners who are already accelerating their careers.
        </p>
      </div>
      
      {#if !isSubmitted}
        <form class="newsletter-form" on:submit|preventDefault={handleSubmit}>
          <div class="form-group">
            <div class="input-wrapper">
              <input
                type="email"
                bind:value={email}
                on:input={handleEmailInput}
                placeholder="Enter your email address"
                class="email-input"
                class:error={errorMessage}
                disabled={isLoading}
                aria-label="Email address for newsletter signup"
                required
              />
              <button
                type="submit"
                class="submit-btn"
                class:loading={isLoading}
                disabled={isLoading}
                aria-label="Subscribe to newsletter"
              >
                {#if isLoading}
                  <span class="loading-spinner"></span>
                  <span>Subscribing...</span>
                {:else}
                  Subscribe
                {/if}
              </button>
            </div>
            {#if errorMessage}
              <div class="error-message" role="alert">
                {errorMessage}
              </div>
            {/if}
          </div>
          
          <div class="newsletter-benefits">
            <div class="benefit">
              <span class="benefit-icon">📚</span>
              <span>Weekly course recommendations</span>
            </div>
            <div class="benefit">
              <span class="benefit-icon">💡</span>
              <span>Exclusive learning tips</span>
            </div>
            <div class="benefit">
              <span class="benefit-icon">🎯</span>
              <span>Early access to new features</span>
            </div>
          </div>
        </form>
      {:else}
        <div class="success-message">
          <div class="success-icon">✅</div>
          <h3 class="success-title">Welcome to the Rabbitly Community!</h3>
          <p class="success-description">
            Thank you for subscribing! We've sent a confirmation email to <strong>{email}</strong>. 
            Check your inbox and click the link to confirm your subscription.
          </p>
          <button 
            class="reset-btn" 
            on:click={() => { isSubmitted = false; email = ''; }}
          >
            Subscribe Another Email
          </button>
        </div>
      {/if}
    </div>
  </div>
</section>

<style>
.newsletter-section {
  margin: 4rem 0;
  padding: 3rem 0;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 2rem;
  position: relative;
  overflow: hidden;
}

.newsletter-section::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="dots" width="20" height="20" patternUnits="userSpaceOnUse"><circle cx="10" cy="10" r="1" fill="white" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23dots)"/></svg>');
  opacity: 0.3;
  pointer-events: none;
}

.newsletter-container {
  max-width: 600px;
  margin: 0 auto;
  padding: 0 2rem;
  position: relative;
  z-index: 1;
}

.newsletter-header {
  text-align: center;
  margin-bottom: 2.5rem;
}

.newsletter-title {
  font-family: 'Nunito', sans-serif;
  font-size: 2.5rem;
  font-weight: 800;
  color: white;
  margin-bottom: 1rem;
  text-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
}

.newsletter-description {
  font-size: 1.1rem;
  color: rgba(255, 255, 255, 0.9);
  line-height: 1.6;
  font-weight: 500;
}

.newsletter-form {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.input-wrapper {
  display: flex;
  gap: 0.5rem;
  background: white;
  border-radius: 1rem;
  padding: 0.5rem;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
  transition: box-shadow 0.2s ease;
}

.input-wrapper:focus-within {
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
}

.email-input {
  flex: 1;
  border: none;
  outline: none;
  padding: 1rem 1.2rem;
  font-size: 1rem;
  background: transparent;
  color: #1e293b;
  font-weight: 500;
}

.email-input::placeholder {
  color: #94a3b8;
}

.email-input.error {
  color: #ef4444;
}

.submit-btn {
  padding: 1rem 2rem;
  background: linear-gradient(135deg, #7c3aed 0%, #4A90E2 100%);
  color: white;
  border: none;
  border-radius: 0.8rem;
  font-weight: 700;
  font-size: 1rem;
  cursor: pointer;
  transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
  white-space: nowrap;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.submit-btn:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(124, 58, 237, 0.3);
  background: linear-gradient(135deg, #4A90E2 0%, #7c3aed 100%);
}

.submit-btn:disabled {
  opacity: 0.7;
  cursor: not-allowed;
}

.submit-btn.loading {
  pointer-events: none;
}

.loading-spinner {
  width: 16px;
  height: 16px;
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-top: 2px solid white;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.error-message {
  color: #fef2f2;
  background: rgba(239, 68, 68, 0.2);
  padding: 0.8rem 1rem;
  border-radius: 0.8rem;
  font-size: 0.9rem;
  font-weight: 500;
  border: 1px solid rgba(239, 68, 68, 0.3);
}

.newsletter-benefits {
  display: flex;
  flex-wrap: wrap;
  gap: 1rem;
  justify-content: center;
  margin-top: 1rem;
}

.benefit {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: rgba(255, 255, 255, 0.9);
  font-size: 0.9rem;
  font-weight: 500;
  padding: 0.5rem 1rem;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 1rem;
  backdrop-filter: blur(10px);
}

.benefit-icon {
  font-size: 1.1rem;
}

.success-message {
  text-align: center;
  color: white;
}

.success-icon {
  font-size: 3rem;
  margin-bottom: 1rem;
}

.success-title {
  font-family: 'Nunito', sans-serif;
  font-size: 1.8rem;
  font-weight: 700;
  margin-bottom: 1rem;
  color: white;
}

.success-description {
  font-size: 1rem;
  line-height: 1.6;
  color: rgba(255, 255, 255, 0.9);
  margin-bottom: 2rem;
}

.reset-btn {
  padding: 0.8rem 1.5rem;
  background: rgba(255, 255, 255, 0.2);
  color: white;
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-radius: 1rem;
  font-weight: 600;
  font-size: 0.95rem;
  cursor: pointer;
  transition: all 0.2s ease;
  backdrop-filter: blur(10px);
}

.reset-btn:hover {
  background: rgba(255, 255, 255, 0.3);
  border-color: rgba(255, 255, 255, 0.5);
  transform: translateY(-1px);
}

@media (max-width: 768px) {
  .newsletter-section {
    margin: 3rem 0;
    padding: 2rem 0;
  }
  
  .newsletter-title {
    font-size: 2rem;
  }
  
  .newsletter-description {
    font-size: 1rem;
  }
  
  .input-wrapper {
    flex-direction: column;
    gap: 0.8rem;
  }
  
  .submit-btn {
    width: 100%;
    justify-content: center;
  }
  
  .newsletter-benefits {
    flex-direction: column;
    align-items: center;
  }
  
  .benefit {
    width: 100%;
    justify-content: center;
  }
}

@media (max-width: 480px) {
  .newsletter-container {
    padding: 0 1rem;
  }
  
  .newsletter-title {
    font-size: 1.8rem;
  }
  
  .success-title {
    font-size: 1.5rem;
  }
}
</style> 