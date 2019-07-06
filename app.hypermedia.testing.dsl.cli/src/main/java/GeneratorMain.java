import java.io.File;
import java.util.Collection;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.filefilter.WildcardFileFilter;

import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.emf.ecore.resource.ResourceSet;
import org.eclipse.xtext.generator.GeneratorContext;
import org.eclipse.xtext.generator.GeneratorDelegate;
import org.eclipse.xtext.generator.JavaIoFileSystemAccess;
import org.eclipse.xtext.util.CancelIndicator;
import org.eclipse.xtext.validation.CheckMode;
import org.eclipse.xtext.validation.IResourceValidator;
import org.eclipse.xtext.validation.Issue;

import com.google.inject.Inject;
import com.google.inject.Provider;
import com.google.inject.Injector;

import app.hypermedia.testing.dsl.CoreStandaloneSetup;

public class GeneratorMain {

	private static Injector injector = new CoreStandaloneSetup().createInjectorAndDoEMFRegistration();

	@Inject Provider<ResourceSet> resourceSetProvider;

	@Inject IResourceValidator validator;

	@Inject GeneratorDelegate generator;

	@Inject JavaIoFileSystemAccess fileAccess;
	
	public static void main(String[] args) {
		GeneratorMain main = injector.getInstance(GeneratorMain.class);
		main.generateDirectory(args[0]);
		System.out.println("Done!");
	}
	
	protected void generateDirectory(String directoryName) {
		File dir = new File(directoryName);
		Collection<File> files = FileUtils.listFiles(dir, new WildcardFileFilter("*.api"), null);
		
		for (File file : files) {
			this.generateOne(file);
		}
	}
		
	protected void generateOne(File input) {
		System.out.printf("Compiling %s %n", input.getPath());
	
		ResourceSet resourceSet = resourceSetProvider.get();
		Resource resource = resourceSet.getResource(URI.createFileURI(input.getPath()), true);
		
		if (!this.validate(resource)) {
			return;
		}

		fileAccess.setOutputPath(input.getParentFile().getPath());
		generator.generate(resource, fileAccess, new GeneratorContext());	
	}
	
	private boolean validate(Resource resource) {
		List<Issue> issues = validator.validate(resource, CheckMode.ALL, CancelIndicator.NullImpl);
		if (!issues.isEmpty()) {
			issues.forEach(issue -> System.out.println(issue.getMessage()));
			return false;
		}

		return true;
	}
}
