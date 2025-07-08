<script lang="ts">
	import { onMount } from 'svelte';
	import { fade, fly } from 'svelte/transition';
	import { quintOut } from 'svelte/easing';

	let email = '';
	let password = '';
	let isLoading = false;
	let showPassword = false;
	let currentStep = 0;
	let progress = 0;

	const steps = [
		{ title: 'Welcome back!', subtitle: 'Ready to continue your learning journey?' },
		{ title: 'Almost there!', subtitle: 'Just a few more details to get you started.' },
		{ title: 'You\'re all set!', subtitle: 'Let\'s begin your adventure!' }
	];

	function handleLogin() {
		if (!email || !password) return;
		
		isLoading = true;
		// Simulate login process
		setTimeout(() => {
			isLoading = false;
			// Handle actual login logic here
			console.log('Login attempt:', { email, password });
		}, 2000);
	}

	function handleSocialLogin(provider: string) {
		console.log(`Logging in with ${provider}`);
		// Handle social login logic here
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
	<title>Login - Rabbitly</title>
</svelte:head>

<div class="min-h-screen bg-gradient-to-br from-blue-50 via-indigo-50 to-purple-50 flex items-center justify-center p-4">
	<!-- Background decorative elements -->
	<div class="absolute inset-0 overflow-hidden pointer-events-none">
		<div class="absolute -top-40 -right-40 w-80 h-80 bg-gradient-to-br from-blue-400/20 to-purple-400/20 rounded-full blur-3xl"></div>
		<div class="absolute -bottom-40 -left-40 w-80 h-80 bg-gradient-to-tr from-green-400/20 to-blue-400/20 rounded-full blur-3xl"></div>
		<div class="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-96 h-96 bg-gradient-to-r from-yellow-400/10 to-orange-400/10 rounded-full blur-3xl"></div>
	</div>

	<!-- Main login card -->
	<div class="relative z-10 w-full max-w-md">
		<!-- Logo and branding -->
		<div class="text-center mb-8" in:fly={{ y: -50, duration: 800, easing: quintOut }}>
			<div class="inline-flex items-center justify-center w-16 h-16 bg-gradient-to-br from-blue-500 to-purple-600 rounded-2xl mb-4 shadow-lg">
				<svg class="w-8 h-8 text-white" fill="currentColor" viewBox="0 0 20 20">
					<path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
				</svg>
			</div>
			<h1 class="text-3xl font-bold bg-gradient-to-r from-blue-600 to-purple-600 bg-clip-text text-transparent">
				Rabbitly
			</h1>
			<p class="text-gray-600 mt-2">Your learning adventure starts here</p>
		</div>

		<!-- Login form card -->
		<div class="bg-white/80 backdrop-blur-lg rounded-3xl shadow-2xl p-8 border border-white/20" 
			 in:fly={{ y: 50, duration: 800, delay: 200, easing: quintOut }}>
			
			<!-- Progress indicator -->
			<div class="mb-6">
				<div class="flex justify-between items-center mb-2">
					<span class="text-sm font-medium text-gray-600">Getting you ready...</span>
					<span class="text-sm font-bold text-blue-600">{progress}%</span>
				</div>
				<div class="w-full bg-gray-200 rounded-full h-2">
					<div class="bg-gradient-to-r from-blue-500 to-purple-600 h-2 rounded-full transition-all duration-300 ease-out" 
						 style="width: {progress}%"></div>
				</div>
			</div>

			<!-- Welcome message -->
			<div class="text-center mb-6" in:fade={{ duration: 600, delay: 400 }}>
				<h2 class="text-2xl font-bold text-gray-800 mb-2">Welcome back!</h2>
				<p class="text-gray-600">Ready to continue your learning journey?</p>
			</div>

			<!-- Login form -->
			<form class="space-y-4" on:submit|preventDefault={handleLogin} in:fade={{ duration: 600, delay: 600 }}>
				<!-- Email field -->
				<div class="relative">
					<label for="email" class="block text-sm font-medium text-gray-700 mb-2">Email</label>
					<div class="relative">
						<input
							id="email"
							type="email"
							bind:value={email}
							class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200 bg-white/50 backdrop-blur-sm"
							placeholder="Enter your email"
							required
						/>
						<div class="absolute inset-y-0 right-0 pr-3 flex items-center">
							<svg class="h-5 w-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207"/>
							</svg>
						</div>
					</div>
				</div>

				<!-- Password field -->
				<div class="relative">
					<label for="password" class="block text-sm font-medium text-gray-700 mb-2">Password</label>
					<div class="relative">
						<input
							id="password"
							type={showPassword ? 'text' : 'password'}
							bind:value={password}
							class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200 bg-white/50 backdrop-blur-sm pr-12"
							placeholder="Enter your password"
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

				<!-- Forgot password link -->
				<div class="text-right">
					<a href="#" class="text-sm text-blue-600 hover:text-blue-700 font-medium transition-colors duration-200">
						Forgot password?
					</a>
				</div>

				<!-- Login button -->
				<button
					type="submit"
					disabled={isLoading || !email || !password}
					class="w-full bg-gradient-to-r from-blue-500 to-purple-600 text-white font-semibold py-3 px-6 rounded-xl hover:from-blue-600 hover:to-purple-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition-all duration-200 transform hover:scale-105 disabled:opacity-50 disabled:cursor-not-allowed disabled:transform-none shadow-lg"
				>
					{#if isLoading}
						<div class="flex items-center justify-center">
							<svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-white" fill="none" viewBox="0 0 24 24">
								<circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
								<path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
							</svg>
							Signing in...
						</div>
					{:else}
						Sign In
					{/if}
				</button>
			</form>

			<!-- Divider -->
			<div class="relative my-6" in:fade={{ duration: 600, delay: 800 }}>
				<div class="absolute inset-0 flex items-center">
					<div class="w-full border-t border-gray-300"></div>
				</div>
				<div class="relative flex justify-center text-sm">
					<span class="px-2 bg-white/80 text-gray-500">Or continue with</span>
				</div>
			</div>

			<!-- Social login buttons -->
			<div class="grid grid-cols-2 gap-3" in:fade={{ duration: 600, delay: 1000 }}>
				<button
					type="button"
					on:click={() => handleSocialLogin('google')}
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
					on:click={() => handleSocialLogin('github')}
					class="flex items-center justify-center px-4 py-2 border border-gray-300 rounded-xl hover:bg-gray-50 transition-colors duration-200 bg-white/50 backdrop-blur-sm"
				>
					<svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 24 24">
						<path d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"/>
					</svg>
					GitHub
				</button>
			</div>

			<!-- Sign up link -->
			<div class="text-center mt-6" in:fade={{ duration: 600, delay: 1200 }}>
				<p class="text-gray-600">
					Don't have an account? 
					<a href="/signup" class="text-blue-600 hover:text-blue-700 font-semibold transition-colors duration-200">
						Sign up for free
					</a>
				</p>
			</div>
		</div>

		<!-- Floating elements for visual appeal -->
		<div class="absolute -top-4 -right-4 w-8 h-8 bg-gradient-to-br from-yellow-400 to-orange-500 rounded-full opacity-60 animate-pulse"></div>
		<div class="absolute -bottom-4 -left-4 w-6 h-6 bg-gradient-to-br from-green-400 to-blue-500 rounded-full opacity-60 animate-pulse" style="animation-delay: 1s;"></div>
		<div class="absolute top-1/2 -right-8 w-4 h-4 bg-gradient-to-br from-purple-400 to-pink-500 rounded-full opacity-60 animate-pulse" style="animation-delay: 2s;"></div>
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
