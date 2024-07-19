#include <iostream>
#include <string>

#include "opentelemetry/exporters/ostream/span_exporter_factory.h"
#include "opentelemetry/sdk/trace/exporter.h"
#include "opentelemetry/sdk/trace/processor.h"
#include "opentelemetry/sdk/trace/simple_processor_factory.h"
#include "opentelemetry/sdk/trace/tracer_provider_factory.h"
#include "opentelemetry/trace/provider.h"

namespace trace_api = opentelemetry::trace;
namespace trace_sdk = opentelemetry::sdk::trace;
namespace trace_exporter = opentelemetry::exporter::trace;

void InitTracer() {
  auto exporter = trace_exporter::OStreamSpanExporterFactory::Create();

  auto processor = trace_sdk::SimpleSpanProcessorFactory::Create(std::move(exporter));

  std::shared_ptr<opentelemetry::trace::TracerProvider> provider =
      trace_sdk::TracerProviderFactory::Create(std::move(processor));

  trace_api::Provider::SetTracerProvider(provider);
}

void CleanupTracer() {
  std::shared_ptr<opentelemetry::trace::TracerProvider> none;

  trace_api::Provider::SetTracerProvider(none);
}

void bar() {
  auto tracer = opentelemetry::trace::Provider::GetTracerProvider()->GetTracer("test-tracer");
  auto span = tracer->StartSpan("test-span-bar");

  std::this_thread::sleep_for(std::chrono::seconds(1));

  span->End();
}

void foo() {
  auto tracer = opentelemetry::trace::Provider::GetTracerProvider()->GetTracer("test-tracer");
  auto span = tracer->StartSpan("test-span-foo");
  auto scope = tracer->WithActiveSpan(span);

  bar();

  span->End();
}

int32_t main(int32_t argc, char **argv) {
  InitTracer();

  foo();

  CleanupTracer();

  return 0;
}
