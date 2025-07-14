<script lang="ts">
	import { onMount } from 'svelte';
	import Title from '../components/course/Title.svelte';
	import ProgressBar from '../components/course/ProgressBar.svelte';
	import TextBox from '../components/course/TextBox.svelte';
	import MultipleChoice from '../components/course/MultipleChoice.svelte';
	import Graph from '../components/course/Graph.svelte';
	import RoomCard from '../components/lobby/RoomCard.svelte';

	// Lobby state management
	let rooms: Array<{
		id: string;
		name: string;
		participants: number;
		maxParticipants: number;
		status: 'waiting' | 'active' | 'completed';
		createdBy: string;
		createdAt: Date;
	}> = [];

	let user = {
		name: '',
		avatar: '',
		isHost: false
	};

	let showCreateRoom = false;
	let newRoomName = '';
	let selectedRoom: string | null = null;

	// Mock data for demonstration
	onMount(() => {
		rooms = [
			{
				id: '1',
				name: 'Math Study Session',
				participants: 3,
				maxParticipants: 8,
				status: 'waiting',
				createdBy: 'Alice',
				createdAt: new Date()
			},
			{
				id: '2',
				name: 'Physics Lab',
				participants: 5,
				maxParticipants: 6,
				status: 'active',
				createdBy: 'Bob',
				createdAt: new Date()
			},
			{
				id: '3',
				name: 'Code Review',
				participants: 2,
				maxParticipants: 4,
				status: 'waiting',
				createdBy: 'Charlie',
				createdAt: new Date()
			}
		];
	});

	function createRoom() {
		if (newRoomName.trim()) {
			const newRoom = {
				id: Date.now().toString(),
				name: newRoomName,
				participants: 1,
				maxParticipants: 8,
				status: 'waiting' as const,
				createdBy: user.name || 'Anonymous',
				createdAt: new Date()
			};
			rooms = [newRoom, ...rooms];
			newRoomName = '';
			showCreateRoom = false;
		}
	}

	function joinRoom(roomId: string) {
		selectedRoom = roomId;
		// Navigate to the room page
		window.location.href = `/room/${roomId}`;
	}

	function leaveRoom() {
		selectedRoom = null;
	}
</script>

<svelte:head>
	<title>Rabbitly - Learning Lobby</title>
</svelte:head>

<div class="lobby-container">
	<!-- Header Section -->
	<header class="lobby-header">
		<Title 
			text="Rabbitly Learning Lobby" 
			level={1}
		/>
		<p class="subtitle">Connect, Collaborate, Learn Together</p>
		
		<div class="user-section">
			<div class="user-info">
				<div class="avatar">{user.name ? user.name[0].toUpperCase() : 'U'}</div>
				<span class="username">{user.name || 'Guest User'}</span>
			</div>
			<button class="btn btn-primary" on:click={() => showCreateRoom = !showCreateRoom}>
				{showCreateRoom ? 'Cancel' : 'Create Room'}
			</button>
		</div>
	</header>

	<!-- Create Room Section -->
	{#if showCreateRoom}
		<div class="create-room-section">
			<div class="input-group">
				<label for="room-name">Room Name</label>
				<input 
					id="room-name"
					type="text" 
					placeholder="Enter room name..."
					bind:value={newRoomName}
					class="room-input"
				/>
			</div>
			<button class="btn btn-success" on:click={createRoom} disabled={!newRoomName.trim()}>
				Create Room
			</button>
		</div>
	{/if}

	<!-- Room List Section -->
	<div class="rooms-section">
		<h2>Available Rooms ({rooms.length})</h2>
		
		<div class="rooms-grid">
			{#each rooms as room (room.id)}
				<RoomCard 
					{room}
					selected={selectedRoom === room.id}
					onJoin={joinRoom}
				/>
			{/each}
		</div>
	</div>

	<!-- Quick Stats Section -->
	<div class="stats-section">
		<div class="stat-card">
			<h3>Active Sessions</h3>
			<div class="stat-value">{rooms.filter(r => r.status === 'active').length}</div>
		</div>
		<div class="stat-card">
			<h3>Total Participants</h3>
			<div class="stat-value">{rooms.reduce((sum, r) => sum + r.participants, 0)}</div>
		</div>
		<div class="stat-card">
			<h3>Available Rooms</h3>
			<div class="stat-value">{rooms.filter(r => r.participants < r.maxParticipants).length}</div>
		</div>
	</div>
</div>

<style>
	.lobby-container {
		max-width: 1200px;
		margin: 0 auto;
		padding: 2rem;
		font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
	}

	.lobby-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 2rem;
		padding-bottom: 1rem;
		border-bottom: 2px solid #e5e7eb;
	}

	.user-section {
		display: flex;
		align-items: center;
		gap: 1rem;
	}

	.user-info {
		display: flex;
		align-items: center;
		gap: 0.5rem;
	}

	.avatar {
		width: 40px;
		height: 40px;
		border-radius: 50%;
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		color: white;
		display: flex;
		align-items: center;
		justify-content: center;
		font-weight: bold;
		font-size: 1.2rem;
	}

	.username {
		font-weight: 500;
		color: #374151;
	}

	.subtitle {
		color: #6b7280;
		font-size: 1.125rem;
		margin: 0;
	}

	.create-room-section {
		background: #f9fafb;
		padding: 1.5rem;
		border-radius: 8px;
		margin-bottom: 2rem;
		display: flex;
		gap: 1rem;
		align-items: end;
	}

	.input-group {
		display: flex;
		flex-direction: column;
		gap: 0.5rem;
		flex: 1;
	}

	.input-group label {
		font-weight: 500;
		color: #374151;
		font-size: 0.875rem;
	}

	.room-input {
		padding: 0.75rem;
		border: 1px solid #d1d5db;
		border-radius: 6px;
		font-size: 0.875rem;
		transition: border-color 0.2s ease;
	}

	.room-input:focus {
		outline: none;
		border-color: #3b82f6;
		box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
	}

	.rooms-section {
		margin-bottom: 2rem;
	}

	.rooms-section h2 {
		margin-bottom: 1rem;
		color: #111827;
		font-size: 1.5rem;
		font-weight: 600;
	}

	.rooms-grid {
		display: grid;
		grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
		gap: 1.5rem;
	}



	.stats-section {
		display: grid;
		grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
		gap: 1rem;
		margin-top: 2rem;
	}

	.stat-card {
		background: white;
		padding: 1.5rem;
		border-radius: 8px;
		border: 1px solid #e5e7eb;
		text-align: center;
	}

	.stat-card h3 {
		margin: 0 0 0.5rem 0;
		color: #6b7280;
		font-size: 0.875rem;
		font-weight: 500;
		text-transform: uppercase;
		letter-spacing: 0.05em;
	}

	.stat-value {
		font-size: 2rem;
		font-weight: 700;
		color: #111827;
	}

	.btn {
		padding: 0.5rem 1rem;
		border: none;
		border-radius: 6px;
		font-weight: 500;
		cursor: pointer;
		transition: all 0.2s ease;
		font-size: 0.875rem;
	}

	.btn-primary {
		background: #3b82f6;
		color: white;
	}

	.btn-primary:hover:not(:disabled) {
		background: #2563eb;
	}

	.btn-success {
		background: #10b981;
		color: white;
	}

	.btn-success:hover:not(:disabled) {
		background: #059669;
	}

	.btn:disabled {
		opacity: 0.5;
		cursor: not-allowed;
	}

	@media (max-width: 768px) {
		.lobby-header {
			flex-direction: column;
			gap: 1rem;
			align-items: stretch;
		}

		.create-room-section {
			flex-direction: column;
			align-items: stretch;
		}

		.rooms-grid {
			grid-template-columns: 1fr;
		}

		.stats-section {
			grid-template-columns: 1fr;
		}
	}
</style>
