<script lang="ts">
	export let room: {
		id: string;
		name: string;
		participants: number;
		maxParticipants: number;
		status: 'waiting' | 'active' | 'completed';
		createdBy: string;
		createdAt: Date;
	};
	
	export let selected: boolean = false;
	export let onJoin: (roomId: string) => void;
	
	import ProgressBar from '../course/ProgressBar.svelte';
</script>

<div class="room-card" class:selected on:click={() => onJoin(room.id)}>
	<div class="room-header">
		<h3>{room.name}</h3>
		<span class="status-badge status-{room.status}">
			{room.status}
		</span>
	</div>
	
	<div class="room-details">
		<div class="participants">
			<span class="participant-count">
				{room.participants}/{room.maxParticipants} participants
			</span>
			<ProgressBar value={room.participants / room.maxParticipants} />
		</div>
		
		<div class="room-meta">
			<span class="created-by">Created by {room.createdBy}</span>
			<span class="created-time">
				{room.createdAt.toLocaleTimeString()}
			</span>
		</div>
	</div>
	
	<div class="room-actions">
		<button 
			class="btn btn-primary"
			on:click|stopPropagation={() => onJoin(room.id)}
			disabled={room.participants >= room.maxParticipants}
		>
			{room.participants >= room.maxParticipants ? 'Full' : 'Join Room'}
		</button>
	</div>
</div>

<style>
	.room-card {
		background: white;
		border: 2px solid #e5e7eb;
		border-radius: 12px;
		padding: 1.5rem;
		transition: all 0.2s ease;
		cursor: pointer;
	}

	.room-card:hover {
		border-color: #3b82f6;
		box-shadow: 0 4px 12px rgba(59, 130, 246, 0.1);
	}

	.room-card.selected {
		border-color: #3b82f6;
		background: #eff6ff;
	}

	.room-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 1rem;
	}

	.room-header h3 {
		margin: 0;
		color: #111827;
		font-size: 1.25rem;
		font-weight: 600;
	}

	.status-badge {
		padding: 0.25rem 0.75rem;
		border-radius: 20px;
		font-size: 0.875rem;
		font-weight: 500;
		text-transform: capitalize;
	}

	.status-waiting {
		background: #fef3c7;
		color: #92400e;
	}

	.status-active {
		background: #d1fae5;
		color: #065f46;
	}

	.status-completed {
		background: #e5e7eb;
		color: #374151;
	}

	.room-details {
		margin-bottom: 1rem;
	}

	.participants {
		margin-bottom: 0.75rem;
	}

	.participant-count {
		display: block;
		margin-bottom: 0.5rem;
		color: #6b7280;
		font-size: 0.875rem;
	}

	.room-meta {
		display: flex;
		justify-content: space-between;
		font-size: 0.75rem;
		color: #9ca3af;
	}

	.room-actions {
		display: flex;
		justify-content: flex-end;
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

	.btn:disabled {
		opacity: 0.5;
		cursor: not-allowed;
	}
</style> 