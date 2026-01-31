"tenant-ns": {
	annotations: {}
	attributes: {
		workload: definition: {
			apiVersion: "v1"
			kind:       "Namespace"
		}
	}
	description: "Standard tenant namespace with resource limits"
	labels: {}
	type: "component"
}

template: {
	output: {
		apiVersion: "v1"
		kind:       "Namespace"
		metadata: name: context.name
	}
	outputs: {
		quota: {
			apiVersion: "v1"
			kind:       "ResourceQuota"
			metadata: {
				name:      context.name + "-quota"
				namespace: context.name
			}
			spec: hard: {
				"cpu":    parameter.cpu
				"memory": parameter.memory
				"pods":   parameter.pods
			}
		}
	}
	parameter: {
		cpu:    * "2" | string
		memory: * "4Gi" | string
		pods:   * "10" | string
	}
}