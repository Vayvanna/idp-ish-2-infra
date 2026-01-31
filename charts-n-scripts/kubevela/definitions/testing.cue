"tenant-ns": {
	attributes: {
		// We leave this empty to tell Vela this isn't a "standard" container workload
	}
	type: "component"
}

template: {
	// Move the namespace to outputs so Vela doesn't try to treat it as a "Workload"
	outputs: {
		ns: {
			apiVersion: "v1"
			kind:       "Namespace"
			metadata: name: context.name
		}
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