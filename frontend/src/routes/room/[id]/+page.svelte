<script lang="ts">
	import { page } from '$app/stores';
	import { onMount } from 'svelte';
	import Title from '../../../components/course/Title.svelte';
	import Graph from '../../../components/course/Graph.svelte';
	import MultipleChoice from '../../../components/course/MultipleChoice.svelte';
	import ProgressBar from '../../../components/course/ProgressBar.svelte';

	// Get room ID from URL
	$: roomId = $page.params.id;

	// Room state
	let room = {
		id: roomId,
		name: 'Loading...',
		participants: [] as Array<{id: string; name: string; isHost: boolean; isOnline: boolean}>,
		status: 'waiting' as 'waiting' | 'active' | 'completed',
		createdBy: '',
		createdAt: new Date()
	};

	let currentUser = {
		id: 'user-' + Date.now(),
		name: 'Anonymous',
		isHost: false
	};

	let participants = [
		{ id: '1', name: 'Alice', isHost: true, isOnline: true },
		{ id: '2', name: 'Bob', isHost: false, isOnline: true },
		{ id: '3', name: 'Charlie', isHost: false, isOnline: false }
	];

	let messages = [
		{ id: '1', user: 'Alice', text: 'Welcome everyone!', timestamp: new Date() },
		{ id: '2', user: 'Bob', text: 'Thanks for creating this session', timestamp: new Date() }
	];

	let newMessage = '';
	let showParticipants = false;

	onMount(() => {
		// Load room data
		room = {
			id: roomId,
			name: 'Math Study Session',
			participants: participants,
			status: 'active' as const,
			createdBy: 'Alice',
			createdAt: new Date()
		};
	});

	function sendMessage() {
		if (newMessage.trim()) {
			messages = [...messages, {
				id: Date.now().toString(),
				user: currentUser.name,
				text: newMessage,
				timestamp: new Date()
			}];
			newMessage = '';
		}
	}

	function leaveRoom() {
		// Navigate back to lobby
		window.history.back();
	}
</script>

<svelte:head>
	<title>Room {room.name} - Rabbitly</title>
</svelte:head>

<div class="room-container">
	<!-- Room Header -->
	<header class="room-header">
		<div class="room-info">
			<Title text={room.name} level={2} />
			<div class="room-status">
				<span class="status-badge status-{room.status}">{room.status}</span>
				<span class="participant-count">{participants.length} participants</span>
			</div>
		</div>
		
		<div class="room-actions">
			<button class="btn btn-secondary" on:click={() => showParticipants = !showParticipants}>
				Participants ({participants.length})
			</button>
			<button class="btn btn-danger" on:click={leaveRoom}>
				Leave Room
			</button>
		</div>
	</header>

	<div class="room-content">
		<!-- Main Content Area -->
		<main class="main-content">
			<!-- Interactive Graph Example -->
			<div class="content-section">
				<h3>Interactive Learning</h3>
				<Graph 
					data={[
						{x: 1, y: 2},
						{x: 2, y: 4},
						{x: 3, y: 6},
						{x: 4, y: 8},
						{x: 5, y: 10}
					]}
					config={{
						type: "regression",
						title: "Linear Regression Example",
						xLabel: "X Values",
						yLabel: "Y Values",
						showGrid: true,
						interactive: true
					}}
				/>
			</div>

			<!-- Quiz Example -->
			<div class="content-section">
				<h3>Quick Quiz</h3>
				<MultipleChoice 
					question="What is the slope of the line in the graph above?"
					choices={[
						{label: "A", text: "1"},
						{label: "B", text: "2"}, 
						{label: "C", text: "3"},
						{label: "D", text: "4"}
					]}
					correctAnswer={["B"]}
				/>
			</div>
		</main>

		<!-- Sidebar -->
		<aside class="sidebar">
			<!-- Participants Panel -->
			{#if showParticipants}
				<div class="participants-panel">
					<h3>Participants</h3>
					<div class="participants-list">
						{#each participants as participant}
							<div class="participant-item" class:host={participant.isHost}>
								<div class="participant-avatar">
									{participant.name[0].toUpperCase()}
								</div>
								<div class="participant-info">
									<span class="participant-name">{participant.name}</span>
									{#if participant.isHost}
										<span class="host-badge">Host</span>
									{/if}
								</div>
								<div class="online-status" class:online={participant.isOnline}></div>
							</div>
						{/each}
					</div>
				</div>
			{/if}

			<!-- Chat Panel -->
			<div class="chat-panel">
				<h3>Chat</h3>
				<div class="messages">
					{#each messages as message}
						<div class="message" class:own={message.user === currentUser.name}>
							<div class="message-header">
								<span class="message-user">{message.user}</span>
								<span class="message-time">
									{message.timestamp.toLocaleTimeString()}
								</span>
							</div>
							<div class="message-text">{message.text}</div>
						</div>
					{/each}
				</div>
				
				<div class="message-input">
					<input 
						type="text" 
						placeholder="Type a message..."
						bind:value={newMessage}
						on:keydown={(e) => e.key === 'Enter' && sendMessage()}
					/>
					<button class="btn btn-primary" on:click={sendMessage}>
						Send
					</button>
				</div>
			</div>
		</aside>
	</div>
</div>

<style>
	.room-container {
		height: 100vh;
		display: flex;
		flex-direction: column;
		background: #f8fafc;
	}

	.room-header {
		background: white;
		padding: 1rem 2rem;
		border-bottom: 1px solid #e5e7eb;
		display: flex;
		justify-content: space-between;
		align-items: center;
	}

	.room-info {
		display: flex;
		align-items: center;
		gap: 1rem;
	}

	.room-status {
		display: flex;
		align-items: center;
		gap: 0.5rem;
	}

	.status-badge {
		padding: 0.25rem 0.75rem;
		border-radius: 20px;
		font-size: 0.875rem;
		font-weight: 500;
		text-transform: capitalize;
	}

	.status-active {
		background: #d1fae5;
		color: #065f46;
	}

	.participant-count {
		color: #6b7280;
		font-size: 0.875rem;
	}

	.room-actions {
		display: flex;
		gap: 0.5rem;
	}

	.room-content {
		flex: 1;
		display: flex;
		overflow: hidden;
	}

	.main-content {
		flex: 1;
		padding: 2rem;
		overflow-y: auto;
	}

	.content-section {
		background: white;
		border-radius: 8px;
		padding: 1.5rem;
		margin-bottom: 1.5rem;
		box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
	}

	.content-section h3 {
		margin: 0 0 1rem 0;
		color: #111827;
		font-size: 1.25rem;
		font-weight: 600;
	}

	.sidebar {
		width: 300px;
		background: white;
		border-left: 1px solid #e5e7eb;
		display: flex;
		flex-direction: column;
	}

	.participants-panel,
	.chat-panel {
		flex: 1;
		padding: 1rem;
		border-bottom: 1px solid #e5e7eb;
	}

	.participants-panel h3,
	.chat-panel h3 {
		margin: 0 0 1rem 0;
		font-size: 1rem;
		font-weight: 600;
		color: #111827;
	}

	.participants-list {
		display: flex;
		flex-direction: column;
		gap: 0.5rem;
	}

	.participant-item {
		display: flex;
		align-items: center;
		gap: 0.75rem;
		padding: 0.5rem;
		border-radius: 6px;
		transition: background-color 0.2s ease;
	}

	.participant-item:hover {
		background: #f9fafb;
	}

	.participant-item.host {
		background: #eff6ff;
	}

	.participant-avatar {
		width: 32px;
		height: 32px;
		border-radius: 50%;
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		color: white;
		display: flex;
		align-items: center;
		justify-content: center;
		font-weight: bold;
		font-size: 0.875rem;
	}

	.participant-info {
		flex: 1;
		display: flex;
		align-items: center;
		gap: 0.5rem;
	}

	.participant-name {
		font-size: 0.875rem;
		font-weight: 500;
		color: #111827;
	}

	.host-badge {
		background: #3b82f6;
		color: white;
		padding: 0.125rem 0.375rem;
		border-radius: 4px;
		font-size: 0.75rem;
		font-weight: 500;
	}

	.online-status {
		width: 8px;
		height: 8px;
		border-radius: 50%;
		background: #d1d5db;
	}

	.online-status.online {
		background: #10b981;
	}

	.messages {
		flex: 1;
		overflow-y: auto;
		margin-bottom: 1rem;
		display: flex;
		flex-direction: column;
		gap: 0.75rem;
		max-height: 300px;
	}

	.message {
		padding: 0.5rem;
		border-radius: 6px;
		background: #f9fafb;
	}

	.message.own {
		background: #eff6ff;
		margin-left: 1rem;
	}

	.message-header {
		display: flex;
		justify-content: space-between;
		margin-bottom: 0.25rem;
	}

	.message-user {
		font-size: 0.75rem;
		font-weight: 600;
		color: #374151;
	}

	.message-time {
		font-size: 0.75rem;
		color: #9ca3af;
	}

	.message-text {
		font-size: 0.875rem;
		color: #111827;
		line-height: 1.4;
	}

	.message-input {
		display: flex;
		gap: 0.5rem;
		padding-top: 0.5rem;
		border-top: 1px solid #e5e7eb;
	}

	.message-input input {
		flex: 1;
		padding: 0.5rem;
		border: 1px solid #d1d5db;
		border-radius: 4px;
		font-size: 0.875rem;
	}

	.message-input input:focus {
		outline: none;
		border-color: #3b82f6;
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

	.btn-primary:hover {
		background: #2563eb;
	}

	.btn-secondary {
		background: #f3f4f6;
		color: #374151;
		border: 1px solid #d1d5db;
	}

	.btn-secondary:hover {
		background: #e5e7eb;
	}

	.btn-danger {
		background: #ef4444;
		color: white;
	}

	.btn-danger:hover {
		background: #dc2626;
	}

	@media (max-width: 768px) {
		.room-header {
			flex-direction: column;
			gap: 1rem;
			align-items: stretch;
		}

		.room-content {
			flex-direction: column;
		}

		.sidebar {
			width: 100%;
			height: 300px;
		}
	}
</style> 