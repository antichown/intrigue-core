module Intrigue
module Issue
class SuspiciousActivityDetected < BaseIssue

  def self.generate(instance_details={source: "ip"})
    to_return = {
      name: "suspicious_activity_detected",
      pretty_name: "Suspicious Activity Detected",
      severity: 3,
      status: "confirmed",
      category: "reputation",
      description: "This entity has recently been detected as having suspicious activity by the source.",
      remediation: "This entity should be further investigated.",
      affected: [],
      references: [ # types: description, remediation, detection_rule, exploit, threat_intel
      ]
    }.merge!(instance_details)

  to_return
  end

end
end
end
