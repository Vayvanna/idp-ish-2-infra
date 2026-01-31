"tenant-ns": {
	type: "component"
	description: "Provision a tenant namespace"
	attributes: {
		workload: type: "autodetects.core.oam.dev"
	}
}

template: {
	// KubeVela MANDATES the 'output' field. 
	// We put a tiny ServiceAccount here so it doesn't clutter 'kubectl get all'.
	output: {
		apiVersion: "v1"
		kind:       "ServiceAccount"
		metadata: {
			name:      "anchor-sa"
			namespace: "vela-system" // Created in a safe, existing namespace first
		}
	}

	outputs: {
		"tenant-namespace": {
			apiVersion: "v1"
			kind:       "Namespace"
			metadata: name: context.name
		}
	}
	
	parameter: {
		cpu:    * "2" | string
		memory: * "4Gi" | string
		pods:   * "10" | string
	}
}