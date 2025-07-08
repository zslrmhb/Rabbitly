<script lang="ts">
	import { onMount } from 'svelte';
	import { fade, fly } from 'svelte/transition';
	import { quintOut } from 'svelte/easing';

	let currentStep = 0;
	let progress = 0;
	let isLoading = false;
	let showPassword = false;
	let showConfirmPassword = false;

	// Form data
	let formData = {
		firstName: '',
		lastName: '',
		email: '',
		password: '',
		confirmPassword: '',
		learningGoal: '',
		experienceLevel: 'beginner'
	};

	const steps = [
		{ title: 'Create your account', subtitle: 'Let\'s get you started on your learning journey' },
		{ title: 'Tell us about yourself', subtitle: 'Help us personalize your experience' },
		{ title: 'Choose your path', subtitle: 'What would you like to learn?' }
	];

	const learningGoals = [
		{ id: 'programming', label: 'Programming & Development', icon: '💻' },
		{ id: 'data-science', label: 'Data Science & Analytics', icon: '📊' },
		{ id: 'design', label: 'Design & Creativity', icon: '🎨' },
		{ id: 'business', label: 'Business & Marketing', icon: '📈' },
		{ id: 'languages', label: 'Languages & Communication', icon: '🌍' },
		{ id: 'other', label: 'Other', icon: '✨' }
	];

	const experienceLevels = [
		{ id: 'beginner', label: 'Beginner', description: 'New to this field' },
		{ id: 'intermediate', label: 'Intermediate', description: 'Some experience' },
		{ id: 'advanced', label: 'Advanced', description: 'Experienced learner' }
	];

	function handleSignup() {
		if (!formData.firstName || !formData.lastName || !formData.email || !formData.password || !formData.confirmPassword) {
			return;
		}

		if (formData.password !== formData.confirmPassword) {
			alert('Passwords do not match');
			return;
		}

		isLoading = true;
		// Simulate signup process
		setTimeout(() => {
			isLoading = false;
			console.log('Signup attempt:', formData);
		}, 2000);
	}

	function handleSocialSignup(provider: string) {
		console.log(`Signing up with ${provider}`);
		// Handle social signup logic here
	}

	function nextStep() {
		if (currentStep < 2) {
			currentStep++;
		}
	}

	function prevStep() {
		if (currentStep > 0) {
			currentStep--;
		}
	}

	onMount(() => {
		// Animate progress bar
		const interval = setInterval(() => {
			if (progress < 100) {
				progress += 1;
			} else {
				clearInterval(interval);
			}
		}, 50);

		return () => clearInterval(interval);
	});
</script>

<svelte:head>
	<title>Sign Up - Rabbitly</title>
</svelte:head>

<div class="min-h-screen bg-gradient-to-br from-green-50 via-blue-50 to-purple-50 flex items-center justify-center p-4">
	<!-- Background decorative elements -->
	<div class="absolute inset-0 overflow-hidden pointer-events-none">
		<div class="absolute -top-40 -right-40 w-80 h-80 bg-gradient-to-br from-green-400/20 to-blue-400/20 rounded-full blur-3xl"></div>
		<div class="absolute -bottom-40 -left-40 w-80 h-80 bg-gradient-to-tr from-purple-400/20 to-pink-400/20 rounded-full blur-3xl"></div>
		<div class="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-96 h-96 bg-gradient-to-r from-yellow-400/10 to-orange-400/10 rounded-full blur-3xl"></div>
	</div>

	<!-- Main signup card -->
	<div class="relative z-10 w-full max-w-lg">
		<!-- Logo and branding -->
		<div class="text-center mb-8" in:fly={{ y: -50, duration: 800, easing: quintOut }}>
			<div class="inline-flex items-center justify-center w-16 h-16 bg-gradient-to-br from-green-500 to-blue-600 rounded-2xl mb-4 shadow-lg">
				<svg class="w-8 h-8 text-white" fill="currentColor" viewBox="0 0 20 20">
					<path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
				</svg>
			</div>
			<h1 class="text-3xl font-bold bg-gradient-to-r from-green-600 to-blue-600 bg-clip-text text-transparent">
				Rabbitly
			</h1>
			<p class="text-gray-600 mt-2">Join thousands of learners worldwide</p>
		</div>

		<!-- Signup form card -->
		<div class="bg-white/80 backdrop-blur-lg rounded-3xl shadow-2xl p-8 border border-white/20" 
			 in:fly={{ y: 50, duration: 800, delay: 200, easing: quintOut }}>
			
			<!-- Progress indicator -->
			<div class="mb-6">
				<div class="flex justify-between items-center mb-2">
					<span class="text-sm font-medium text-gray-600">Setting up your account...</span>
					<span class="text-sm font-bold text-green-600">{progress}%</span>
				</div>
				<div class="w-full bg-gray-200 rounded-full h-2">
					<div class="bg-gradient-to-r from-green-500 to-blue-600 h-2 rounded-full transition-all duration-300 ease-out" 
						 style="width: {progress}%"></div>
				</div>
			</div>

			<!-- Step indicator -->
			<div class="flex justify-center mb-6">
				<div class="flex space-x-2">
					{#each [0, 1, 2] as step}
						<div class="w-3 h-3 rounded-full transition-all duration-300 {currentStep >= step ? 'bg-green-500' : 'bg-gray-300'}"></div>
					{/each}
				</div>
			</div>

			<!-- Welcome message -->
			<div class="text-center mb-6" in:fade={{ duration: 600, delay: 400 }}>
				<h2 class="text-2xl font-bold text-gray-800 mb-2">{steps[currentStep].title}</h2>
				<p class="text-gray-600">{steps[currentStep].subtitle}</p>
			</div>

			<!-- Step 1: Basic Information -->
			{#if currentStep === 0}
				<form class="space-y-4" in:fade={{ duration: 600, delay: 600 }}>
					<div class="grid grid-cols-2 gap-4">
						<div>
							<label for="firstName" class="block text-sm font-medium text-gray-700 mb-2">First Name</label>
							<input
								id="firstName"
								type="text"
								bind:value={formData.firstName}
								class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all duration-200 bg-white/50 backdrop-blur-sm"
								placeholder="John"
								required
							/>
						</div>
						<div>
							<label for="lastName" class="block text-sm font-medium text-gray-700 mb-2">Last Name</label>
							<input
								id="lastName"
								type="text"
								bind:value={formData.lastName}
								class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all duration-200 bg-white/50 backdrop-blur-sm"
								placeholder="Doe"
								required
							/>
						</div>
					</div>

					<div>
						<label for="email" class="block text-sm font-medium text-gray-700 mb-2">Email</label>
						<input
							id="email"
							type="email"
							bind:value={formData.email}
							class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all duration-200 bg-white/50 backdrop-blur-sm"
							placeholder="john@example.com"
							required
						/>
					</div>

					<div>
						<label for="password" class="block text-sm font-medium text-gray-700 mb-2">Password</label>
						<div class="relative">
							<input
								id="password"
								type={showPassword ? 'text' : 'password'}
								bind:value={formData.password}
								class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all duration-200 bg-white/50 backdrop-blur-sm pr-12"
								placeholder="Create a strong password"
								required
							/>
							<button
								type="button"
								class="absolute inset-y-0 right-0 pr-3 flex items-center"
								on:click={() => showPassword = !showPassword}
							>
								{#if showPassword}
									<svg class="h-5 w-5 text-gray-400 hover:text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
										<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.878 9.878L3 3m6.878 6.878L21 21"/>
									</svg>
								{:else}
									<svg class="h-5 w-5 text-gray-400 hover:text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
										<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
										<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
									</svg>
								{/if}
							</button>
						</div>
					</div>

					<div>
						<label for="confirmPassword" class="block text-sm font-medium text-gray-700 mb-2">Confirm Password</label>
						<div class="relative">
							<input
								id="confirmPassword"
								type={showConfirmPassword ? 'text' : 'password'}
								bind:value={formData.confirmPassword}
								class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all duration-200 bg-white/50 backdrop-blur-sm pr-12"
								placeholder="Confirm your password"
								required
							/>
							<button
								type="button"
								class="absolute inset-y-0 right-0 pr-3 flex items-center"
								on:click={() => showConfirmPassword = !showConfirmPassword}
							>
								{#if showConfirmPassword}
									<svg class="h-5 w-5 text-gray-400 hover:text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
										<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.878 9.878L3 3m6.878 6.878L21 21"/>
									</svg>
								{:else}
									<svg class="h-5 w-5 text-gray-400 hover:text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
										<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
										<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
									</svg>
								{/if}
							</button>
						</div>
					</div>

					<button
						type="button"
						on:click={nextStep}
						disabled={!formData.firstName || !formData.lastName || !formData.email || !formData.password || !formData.confirmPassword}
						class="w-full bg-gradient-to-r from-green-500 to-blue-600 text-white font-semibold py-3 px-6 rounded-xl hover:from-green-600 hover:to-blue-700 focus:outline-none focus:ring-2 focus:ring-green-500 focus:ring-offset-2 transition-all duration-200 transform hover:scale-105 disabled:opacity-50 disabled:cursor-not-allowed disabled:transform-none shadow-lg"
					>
						Continue
					</button>
				</form>
			{/if}

			<!-- Step 2: Experience Level -->
			{#if currentStep === 1}
				<div class="space-y-4" in:fade={{ duration: 600, delay: 600 }}>
					<div>
						<label class="block text-sm font-medium text-gray-700 mb-4">What's your experience level?</label>
						<div class="space-y-3">
							{#each experienceLevels as level}
								<label class="flex items-center p-4 border border-gray-300 rounded-xl cursor-pointer hover:bg-gray-50 transition-colors duration-200 {formData.experienceLevel === level.id ? 'border-green-500 bg-green-50' : ''}">
									<input
										type="radio"
										bind:group={formData.experienceLevel}
										value={level.id}
										class="sr-only"
									/>
									<div class="flex items-center">
										<div class="w-4 h-4 border-2 border-gray-300 rounded-full mr-3 flex items-center justify-center {formData.experienceLevel === level.id ? 'border-green-500' : ''}">
											{#if formData.experienceLevel === level.id}
												<div class="w-2 h-2 bg-green-500 rounded-full"></div>
											{/if}
										</div>
										<div>
											<div class="font-medium text-gray-900">{level.label}</div>
											<div class="text-sm text-gray-500">{level.description}</div>
										</div>
									</div>
								</label>
							{/each}
						</div>
					</div>

					<div class="flex space-x-3">
						<button
							type="button"
							on:click={prevStep}
							class="flex-1 bg-gray-100 text-gray-700 font-semibold py-3 px-6 rounded-xl hover:bg-gray-200 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 transition-all duration-200"
						>
							Back
						</button>
						<button
							type="button"
							on:click={nextStep}
							class="flex-1 bg-gradient-to-r from-green-500 to-blue-600 text-white font-semibold py-3 px-6 rounded-xl hover:from-green-600 hover:to-blue-700 focus:outline-none focus:ring-2 focus:ring-green-500 focus:ring-offset-2 transition-all duration-200 transform hover:scale-105 shadow-lg"
						>
							Continue
						</button>
					</div>
				</div>
			{/if}

			<!-- Step 3: Learning Goals -->
			{#if currentStep === 2}
				<div class="space-y-4" in:fade={{ duration: 600, delay: 600 }}>
					<div>
						<label class="block text-sm font-medium text-gray-700 mb-4">What would you like to learn?</label>
						<div class="grid grid-cols-2 gap-3">
							{#each learningGoals as goal}
								<label class="flex flex-col items-center p-4 border border-gray-300 rounded-xl cursor-pointer hover:bg-gray-50 transition-colors duration-200 {formData.learningGoal === goal.id ? 'border-green-500 bg-green-50' : ''}">
									<input
										type="radio"
										bind:group={formData.learningGoal}
										value={goal.id}
										class="sr-only"
									/>
									<div class="text-2xl mb-2">{goal.icon}</div>
									<div class="text-sm font-medium text-center text-gray-900">{goal.label}</div>
								</label>
							{/each}
						</div>
					</div>

					<div class="flex space-x-3">
						<button
							type="button"
							on:click={prevStep}
							class="flex-1 bg-gray-100 text-gray-700 font-semibold py-3 px-6 rounded-xl hover:bg-gray-200 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 transition-all duration-200"
						>
							Back
						</button>
						<button
							type="button"
							on:click={handleSignup}
							disabled={isLoading || !formData.learningGoal}
							class="flex-1 bg-gradient-to-r from-green-500 to-blue-600 text-white font-semibold py-3 px-6 rounded-xl hover:from-green-600 hover:to-blue-700 focus:outline-none focus:ring-2 focus:ring-green-500 focus:ring-offset-2 transition-all duration-200 transform hover:scale-105 disabled:opacity-50 disabled:cursor-not-allowed disabled:transform-none shadow-lg"
						>
							{#if isLoading}
								<div class="flex items-center justify-center">
									<svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-white" fill="none" viewBox="0 0 24 24">
										<circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
										<path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
									</svg>
									Creating account...
								</div>
							{:else}
								Create Account
							{/if}
						</button>
					</div>
				</div>
			{/if}

			<!-- Divider -->
			<div class="relative my-6" in:fade={{ duration: 600, delay: 800 }}>
				<div class="absolute inset-0 flex items-center">
					<div class="w-full border-t border-gray-300"></div>
				</div>
				<div class="relative flex justify-center text-sm">
					<span class="px-2 bg-white/80 text-gray-500">Or sign up with</span>
				</div>
			</div>

			<!-- Social signup buttons -->
			<div class="grid grid-cols-2 gap-3" in:fade={{ duration: 600, delay: 1000 }}>
				<button
					type="button"
					on:click={() => handleSocialSignup('google')}
					class="flex items-center justify-center px-4 py-2 border border-gray-300 rounded-xl hover:bg-gray-50 transition-colors duration-200 bg-white/50 backdrop-blur-sm"
				>
					<svg class="w-5 h-5 mr-2" viewBox="0 0 24 24">
						<path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
						<path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
						<path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/>
						<path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"/>
					</svg>
					Google
				</button>
				<button
					type="button"
					on:click={() => handleSocialSignup('github')}
					class="flex items-center justify-center px-4 py-2 border border-gray-300 rounded-xl hover:bg-gray-50 transition-colors duration-200 bg-white/50 backdrop-blur-sm"
				>
					<svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 24 24">
						<path d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"/>
					</svg>
					GitHub
				</button>
			</div>

			<!-- Sign in link -->
			<div class="text-center mt-6" in:fade={{ duration: 600, delay: 1200 }}>
				<p class="text-gray-600">
					Already have an account? 
					<a href="/" class="text-green-600 hover:text-green-700 font-semibold transition-colors duration-200">
						Sign in here
					</a>
				</p>
			</div>
		</div>

		<!-- Floating elements for visual appeal -->
		<div class="absolute -top-4 -right-4 w-8 h-8 bg-gradient-to-br from-green-400 to-blue-500 rounded-full opacity-60 animate-pulse"></div>
		<div class="absolute -bottom-4 -left-4 w-6 h-6 bg-gradient-to-br from-purple-400 to-pink-500 rounded-full opacity-60 animate-pulse" style="animation-delay: 1s;"></div>
		<div class="absolute top-1/2 -right-8 w-4 h-4 bg-gradient-to-br from-yellow-400 to-orange-500 rounded-full opacity-60 animate-pulse" style="animation-delay: 2s;"></div>
	</div>
</div>

<style>
	/* Custom animations */
	@keyframes float {
		0%, 100% { transform: translateY(0px); }
		50% { transform: translateY(-10px); }
	}
	
	.animate-float {
		animation: float 3s ease-in-out infinite;
	}
</style> 