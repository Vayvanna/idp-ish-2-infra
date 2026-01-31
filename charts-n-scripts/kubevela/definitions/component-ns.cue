"tenant-ns": {
	attributes: {
		workload: definition: {
			apiVersion: "v1"
			kind:       "Namespace"
		}
	}
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